# 设置环境变量
$env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot"
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"
$env:MAVEN_HOME = "D:\apache-maven-3.9.14-bin\apache-maven-3.9.14"
$env:PATH = "$env:MAVEN_HOME\bin;$env:PATH"

# 切换到项目目录
Set-Location "d:\OnCall\SuperBizAgent-release-2026-01-02"

Write-Host "正在启动 SreAgent 服务..." -ForegroundColor Yellow

# 检查 Java
Write-Host "Java 版本:" -ForegroundColor Cyan
java -version

# 检查 Maven
Write-Host "`nMaven 版本:" -ForegroundColor Cyan
mvn -version

# 启动服务
Write-Host "`n正在编译并启动服务..." -ForegroundColor Yellow
$process = Start-Process -FilePath "mvn" -ArgumentList "clean", "compile", "spring-boot:run", "-Dspring-boot.run.jvmArguments=-Xmx512m" -RedirectStandardOutput "server.log" -RedirectStandardError "server-error.log" -WindowStyle Hidden -PassThru

# 保存进程ID
$process.Id | Out-File "server.pid"

Write-Host "服务已启动，PID: $($process.Id)" -ForegroundColor Green
Write-Host "查看日志: Get-Content server.log -Tail 50" -ForegroundColor Cyan

# 等待服务启动
Write-Host "`n等待服务启动..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# 检查服务是否启动
try {
    $response = Invoke-WebRequest -Uri "http://localhost:9900/milvus/health" -UseBasicParsing -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        Write-Host "服务启动成功！" -ForegroundColor Green
        Write-Host "访问地址: http://localhost:9900" -ForegroundColor Green
        Write-Host "健康检查: http://localhost:9900/milvus/health" -ForegroundColor Green
    }
} catch {
    Write-Host "服务可能还在启动中，请稍后再检查" -ForegroundColor Yellow
    Write-Host "查看日志: Get-Content server.log -Tail 50" -ForegroundColor Cyan
}