---
title: "Scripting in Fiji"
date: 2026-06-16T22:21:43+08:00
lastmod: 2026-06-24T02:04:44+08:00
comments: true
tags:
    - Fiji/ImageJ
---

**什么是 ImageJ 的插件？**

> Technically, ImageJ is built on the SciJava Common plugin framework. Within this framework, a plugin is a Java class annotated with the [`@Plugin`](https://github.com/scijava/scijava-common/blob/scijava-common-2.47.0/src/main/java/org/scijava/plugin/Plugin.java) (点击链接查看支持的参数) annotation. Classes annotated in this way are then automatically discovered and indexed at “runtime”, when the application is launched by a user (as opposed to “compile-time”).

<!--more-->

> [!NOTE]+ 参考链接
> 
> - ImageJ 官方教程：https://imagej.net/tutorials/
> - ImageJ 开发指南：https://imagej.net/develop/
>     - 开发插件：https://imagej.net/develop/plugins
> - ImageJ 脚本编写：https://imagej.net/scripting/
> - 如何查找 `pom-scijava` 中的包：
>     - https://github.com/scijava/pom-scijava/blob/master/pom.xml
>     - https://maven.scijava.org/#browse/welcome
> - 所有 Scijava 相关项目的 Java 文档：https://javadoc.scijava.org/

## 创建插件类

ImageJ 发现的所有插件（`@Plugin` 修饰的类）都可以通过一个唯一的 [`Content`](https://github.com/scijava/scijava-common/blob/scijava-common-2.47.0/src/main/java/org/scijava/Context.java) 类来索引。每个应用（比如 ImageJ、Fiji）都自己负责创建自己的 `Context` 并管理插件和*上下文状态（contextual state）*。ImageJ 启动时会自动创建一个 `Context`，所以插件开发者不需要创建自己的 `Context`。

当需要使用统一的 `Context` 管理的其他插件（如 [`LogService`](https://github.com/scijava/scijava-common/blob/scijava-common-2.47.0/src/main/java/org/scijava/log/LogService.java)）时，不应该自己创建实例，而应该通过 `@Parameter` 注释来向 `Context` 请求对象实例来作为插件类的成员（field）：

```java
@Plugin
public class MyPlugin {
 
  // This @Parameter notation is 'asking' the Context
  // for an instance of LogService.
  @Parameter
  private LogService logService;
 
  public void log(String message) {
    // Just use the LogService!
    // There is no need to construct it, since the Context
    // has already provided an appropriate instance.
    logService.info(message);
  }
}
```

`Context` 创建时，会自动处理插件之间的依赖关系。

注意，只有当插件是按上述流程通过插件框架创建时，`@Parameter` 对象才会被自动填充。当手动创建（`new MyPlugin()`）时，需要获取当前的 `Context`（也是借助 `@Parameter`）并注入（`context.inject()`）插件实例：

```java
public class MyService {

  // This service will manually create plugin instances
  // So, we need a reference to our containing Context
  // Then we can use it to inject our plugins.
  @Parameter
  private Context context;

  public void doStuff() {
    // Manually create a plugin instance
    // It is not connected to a Context yet
    MyPlugin plugin = new MyPlugin();

    // Inject the plugin instance with our Context,
    // so the logService field of the plugin will be
    // populated.
    context.inject(plugin);

    // Now that our plugin is injected, we can use
    // it with the knowledge that its parameters
    // have been populated
    plugin.log("Success!");
  }
}
```

注意到，被注入的插件示例 `plugin` 可以使用其 `log()` 成员函数，说明插件示例被正确地连接到了现有的 `Context` 网络中。

## 插件类型

### Services

`Services` 为 Scijava 提供了两个重要功能*工具方法（utility methods）*和*持续状态（persistent state）*，即可以用来创建 Scijava 框架全局可用的方法和用来追踪 `Context` 范围的变量或者配置。

一个 `Service` 是特定 `Context` 中的一个静态工具类，每个 `Context` 只能有特定 `Service` 的一个实例。当向 `Context` 请求特定 `Service` 时，只有优先级（`priority`）最高的实例会被返回。

### Commands

`Commands` 则是设计为一次性执行的插件。`Commands` 构成了 ImageJ GUI 的菜单，向非开发者暴露功能和算法。当一个 `Command` 执行时，它会经历一系列预处理流程，来通过关联的 `Context` 生成所需的 `@Parameter` 实例。如果有 `@Parameter` 对象不能被解析（如整数、字符串对象）且 UI 可用，Scijava 会自动生成对话框来获取用户输入。

`Command` 开发的常见模式是包装（wrap）`Services`，作为后者的


> [!NOTE]- 示例 `pom.xml`
>
>  ```xml
>  <?xml version="1.0" encoding="UTF-8"?>
>  <!--https://github.com/imagej/tutorials/blob/master/java/ij2-image-plus/pom.xml-->
>  <project xmlns="http://maven.apache.org/POM/4.0.0"
>           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
>           xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
>      <modelVersion>4.0.0</modelVersion>
>  
>      <!-- https://github.com/scijava/pom-scijava/blob/master/pom.xml -->
>      <parent>
>          <groupId>org.scijava</groupId>
>          <artifactId>pom-scijava</artifactId>
>          <version>42.0.0</version> <relativePath />
>      </parent>
>  
>      <groupId>cn.org.aya</groupId>
>      <artifactId>IFAnalyzer</artifactId>
>      <version>1.0-SNAPSHOT</version>
>      <packaging>jar</packaging>
>  
>      <name>IFAnalyzer</name>
>      <description>A Fiji plugin for immunofluorescence analysis.</description>
>  
>      <url>https://github.com/alohaia/TODO</url>
>      <inceptionYear>2026</inceptionYear>
>      <organization>
>          <name>Qihuan</name>
>          <url>https://aya.org.cn</url>
>      </organization>
>      <licenses>
>          <license>
>              <name>Unlicense</name>
>              <url>https://unlicense.org/</url>
>              <distribution>repo</distribution>
>          </license>
>      </licenses>
>  <!--    <licenses>-->
>  <!--        <license>-->
>  <!--            <name>MIT License</name>-->
>  <!--            <url>https://opensource.org/licenses/MIT</url>-->
>  <!--        </license>-->
>  <!--    </licenses>-->
>      <developers>
>          <developer>
>              <id>Qihuan</id>
>              <name>Qihuan Liu</name>
>              <url>https://imagej.net/User:[MY-IMAGEJ-WIKI-ACCOUNT]</url>
>          </developer>
>      </developers>
>      <contributors>
>          <contributor>
>              <name>None</name>
>          </contributor>
>      </contributors>
>  
>      <mailingLists>
>          <mailingList>
>              <name>Image.sc Forum</name>
>              <archive>https://forum.image.sc/tags/imagej</archive>
>          </mailingList>
>      </mailingLists>
>  
>  <!--    <scm>-->
>  <!--        <connection>scm:git:git://github.com/[MY-ORG]/[MY-REPO]</connection>-->
>  <!--        <developerConnection>scm:git:git@github.com:[MY-ORG]/[MY-REPO]</developerConnection>-->
>  <!--        <tag>HEAD</tag>-->
>  <!--        <url>https://github.com/[MY-ORG]/[MY-REPO]</url>-->
>  <!--    </scm>-->
>  <!--    <issueManagement>-->
>  <!--        <system>GitHub Issues</system>-->
>  <!--        <url>http://github.com/[MY-ORG]/[MY-REPO]/issues</url>-->
>  <!--    </issueManagement>-->
>      <ciManagement>
>          <system>None</system>
>      </ciManagement>
>  
>      <repositories>
>          <repository>
>              <id>scijava.public</id>
>              <url>https://maven.scijava.org/content/groups/public</url>
>          </repository>
>      </repositories>
>  
>      <dependencies>
>          <!-- Groovy -->
>          <dependency>
>              <groupId>org.apache.groovy</groupId>
>              <artifactId>groovy</artifactId>
>          </dependency>
>          <dependency>
>              <groupId>org.scijava</groupId>
>              <artifactId>scripting-groovy</artifactId>
>          </dependency>
>  
>          <!-- NB: For ImageJ 1.x support. -->
>          <dependency>
>              <groupId>net.imagej</groupId>
>              <artifactId>ij</artifactId>
>          </dependency>
>          <dependency>
>              <groupId>net.imagej</groupId>
>              <artifactId>imagej-legacy</artifactId>
>          </dependency>
>      </dependencies>
>  
>      <properties>
>          <main-class>DatasetWrapping</main-class>
>          <license.licenseName>unlicense</license.licenseName>
>          <license.copyrightOwners>N/A</license.copyrightOwners>
>          <license.projectName>ImageJ software for multidimensional image processing and analysis.</license.projectName>
>  
>          <!-- IntelliJ IDEA-->
>          <maven.compiler.source>21</maven.compiler.source>
>          <maven.compiler.target>21</maven.compiler.target>
>          <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
>      </properties>
>  
>  </project>
>  ```


## ImageJ 的 UI 开发

ImageJ 提供了 `java.awt.*` 和 `javax.swing.*` UI 库，前者的存在主要是由于历史包袱，推荐使用后者，即 Swing 框架。


## 其他

RoiManager 的可用命令见 `runCommand()` 函数。
