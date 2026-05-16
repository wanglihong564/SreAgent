@echo off
chcp 65001 >nul
echo 正在启动 SreAgent 服务...
cd /d "d:\OnCall\SuperBizAgent-release-2026-01-02"

:: 设置环境变量
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%
set MAVEN_HOME=D:\apache-maven-3.9.14-bin\apache-maven-3.9.14
set PATH=%MAVEN_HOME%\bin;%PATH%

echo Java 版本:
java -version
echo.
echo Maven 版本:
mvn -version
echo.
echo 正在编译并启动服务...
mvn clean compile spring-boot:run -Dspring-boot.run.jvmArguments="-Xmx512m" > server.log 2>&1 &

echo 服务启动中，请查看 server.log 文件
timeout /t 5 /nobreak >nul

:: 检查服务是否启动
curl -s http://localhost:9900/milvus/health >nul 2>&1
if %errorlevel% == 0 (
    echo 服务启动成功！
    echo 访问地址: http://localhost:9900
) else (
    echo 服务可能还在启动中，请稍后再检查
    echo 查看日志: type server.log
)

pause