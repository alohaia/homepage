---
title: 2026-05-16 备份脚本
date: 2026-05-16T10:50:59+08:00
lastmod: 2026-05-16T10:58:20+08:00
comments: true
---

新买了块机械硬盘，写了个备份脚本。

<!--more-->

首先将 `/dev/sda` 创建为包含单个 Btrfs 文件系统（`/dev/sda1`）的磁盘。

完整备份脚本，放在硬盘根目录：

```bash
#!/usr/bin/env bash

set -euo pipefail

is_subvolume() {
    btrfs subvolume show "$1" >/dev/null 2>&1
}

is_subvolume_of() {
    local src="$1"
    local backup="$2"

    src=$(realpath "$src")
    backup=$(realpath "$backup")

    local rel="${src#$backup/}"

    [[ "$src" == "$backup"* ]] && (sudo btrfs subvolume list "$backup" | grep -q "path $rel$")
}

get_mountpoint_by_uuid() {
    local uuid="$1"
    findmnt -rn -S "$(blkid -U "$uuid")" -o TARGET
}

is_win_fs() {
    df -T $1 | awk 'NR==2 {print $2}' | grep -Eq "drvfs|ntfs3?|cifs|exfat|vfat|fat|msdos"
}

########################################
# Configs
########################################

################# UUID of backup target device #################
BACKUP_UUID="f830eaed-4a50-4ee7-af0b-003575f58a83"
################################################################

BACKUP_DISC=$(get_mountpoint_by_uuid "$BACKUP_UUID")

echo -n "CHECKing backup target device... "

if [[ -n "$BACKUP_DISC" ]]; then
    echo "YES"
    echo -e "\t$BACKUP_UUID is mounted at: $BACKUP_DISC"
else
    echo "NO"
    echo -e "\t$BACKUP_UUID not found or not mounted."
    exit 1
fi

BACKUP_ROOT="$BACKUP_DISC/backups"
SNAPSHOT_ROOT="$BACKUP_DISC/snapshots"
LOG_ROOT="$BACKUP_DISC/logs"

DATE="$(date +%F_%H-%M-%S)"
LOG_FILE="${LOG_ROOT}/backup_${DATE}.log"

########################################
# Backup sources, format
# name:source_path
########################################

CONFIG_FILE="./backup_sources.conf"

if [ "$#" -gt 0 ]; then
    SOURCES=("$@")
else
    echo "No command-line arguments specified, use default config file: $CONFIG_FILE"
    echo "Command-line arguments: $0 name:/path name:/path ..."
    mapfile -t SOURCES < <(
        grep -vE '^\s*#|^\s*$' "$CONFIG_FILE" # ignore empty lines or lines start with #
    )
fi


########################################
# Pre-checks
########################################

echo "====================================="
echo "Pre-checks"
echo "====================================="

# check if bakcup target device is Btrfs
FS_TYPE="$(findmnt -n -o FSTYPE $BACKUP_DISC)"

if [[ "$FS_TYPE" != "btrfs" ]]; then
    echo "ERROR: $BACKUP_DISC is not Btrfs"
    exit 1
else
    echo "PASS: $BACKUP_DISC is a Btrfs filesystem"
fi


########################################
# Initialization
########################################

mkdir -p "$BACKUP_ROOT"
mkdir -p "$SNAPSHOT_ROOT"
mkdir -p "$LOG_ROOT"

exec > >(tee -a "$LOG_FILE") 2>&1

echo
echo "====================================="
echo "Backup started: $(date)"
echo "====================================="

########################################
# rsync options
########################################

RSYNC_OPTS_LINUX=(
    -aHAX
)
RSYNC_OPTS_WIN=(
    -rtvh
    --no-xattrs
    --no-acls
    --no-perms
)
RSYNC_OPTS=(
    --numeric-ids
    --delete
    --delete-delay
    --info=progress2
    --human-readable

    --exclude=.cache
    --exclude=node_modules
    --exclude=__pycache__
    --exclude=.Trash-1000

    # Windows files
    --exclude='$RECYCLE.BIN/'
    --exclude='System Volume Information/'
    --exclude='$RECYCLE.BIN/'
    --exclude='System Volume Information/'
    --exclude='Windows/'
    --exclude='Program Files/'
    --exclude='Program Files (x86)/'
    --exclude='ProgramData/'

    --exclude='Saved Games/' # /windt/System/Saved Games/
)

########################################
# The main backup function
########################################

backup_target() {

    local NAME="$1"
    local SRC=$(realpath "$2")

    local DEST="${BACKUP_ROOT}/${NAME}"

    # check if backuping itself
    if [[ "$SRC" == "$BACKUP_DISC" ]]; then
        echo "SKIP: source is backuping disk itself ($BACKUP_DISC)."
        exit 1
    fi

    ########################################
    # rsync backup
    ########################################

    echo
    echo "-------------------------------------"
    echo "Backing up: ${SRC}"
    echo "Destination: ${DEST}"
    echo "-------------------------------------"

    echo -n "CHECKing if source $SRC exists... "
    if [[ ! -d "$SRC" ]]; then
        echo "NO"
        return
    else
        echo "YES"
    fi

    echo -n "CHECKing if source $SRC is a Btrfs subvolume of $BACKUP_DISC... "
    local ISSUBV=0
    if is_subvolume_of "$SRC" "$BACKUP_DISC"; then
        echo "YES, only snapshot!"
        ISSUBV=1
    else
        echo "NO, rsync + snapshot."
    fi

    echo
    if [[ "$ISSUBV" -eq 1 ]]; then
        echo "---> Skip rsync <---"
    else
        echo "---> Start rsync <---"
        echo -n "CHECKing if destination $DEST subvolume exists... "
        if ! btrfs subvolume show "$DEST" >/dev/null 2>&1; then

            echo "NO"
            echo -e "\tCreating Btrfs subvolume:"
            echo -e "\t$DEST"

            mkdir -p "$(dirname "$DEST")"

            btrfs subvolume create "$DEST"
        else
            echo "YES"
        fi

        if is_win_fs $SRC; then
            rsync \
                "${RSYNC_OPTS_WIN[@]}" \
                "${RSYNC_OPTS[@]}" \
                "$SRC"/ \
                "$DEST"/
        else
            rsync \
                "${RSYNC_OPTS_LINUX[@]}" \
                "${RSYNC_OPTS[@]}" \
                "$SRC"/ \
                "$DEST"/
        fi
        echo "---> End rsync <---"
    fi


    ########################################
    # Create read-only snapshot
    ########################################

    echo
    echo "---> Start snapshot <---"

    local SNAPSHOT="${SNAPSHOT_ROOT}/${NAME}_${DATE}"

    echo "Creating snapshot $SNAPSHOT"
    if [[ "ISSUBV" -eq 1 ]]; then
        echo -e "\t for $SRC"

        btrfs subvolume snapshot -r \
            "$SRC" \
            "$SNAPSHOT"
    else
        echo -e "\t for $DEST"

        btrfs subvolume snapshot -r \
            "$DEST" \
            "$SNAPSHOT"
    fi

    echo "---> End snapshot <---"
}

########################################
# Start backup
########################################

for ITEM in "${SOURCES[@]}"; do

    NAME="${ITEM%%:*}"
    SRC="${ITEM#*:}"

    backup_target "$NAME" "$SRC"

done

########################################
# Finished
########################################

echo
echo "====================================="
echo "Backup finished: $(date)"
echo "Log:"
echo "$LOG_FILE"
echo "====================================="
```


配置文件 `backup_sources.conf`：

```text
# Format: name:source_path
home:/home
etc:/etc
data:/data
selfdata:./data
windows_data:/windt/System/
```

使用时为了考虑文件系统挂载时可能使用了 `noexec` 选项，可以这样运行脚本：

```sudo
sudo bash backup.sh
```
