# 贡献指南

感谢你对 SreAgent 项目的关注！我们欢迎任何形式的贡献。

## 🤝 如何贡献

### 报告问题

如果你发现了 bug 或有功能建议，请：

1. 在 [Issues](../../issues) 中搜索是否已有类似问题
2. 如果没有，创建一个新的 Issue，包含：
   - 清晰的标题和描述
   - 复现步骤（如果是 bug）
   - 期望行为和实际行为
   - 环境信息（Java 版本、操作系统等）

### 提交代码

1. **Fork 本仓库**

2. **克隆你的 Fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/SreAgent.git
   cd SreAgent
   ```

3. **创建分支**
   ```bash
   git checkout -b feature/your-feature-name
   # 或
   git checkout -b fix/your-bug-fix
   ```

4. **进行修改**
   - 遵循现有的代码风格
   - 添加必要的测试
   - 更新相关文档

5. **提交更改**
   ```bash
   git add .
   git commit -m "feat: 添加新功能描述"
   # 或
   git commit -m "fix: 修复问题描述"
   ```

6. **推送到 Fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **创建 Pull Request**
   - 描述你的更改内容
   - 关联相关的 Issue

## 📝 代码规范

### Java 代码

- 遵循 [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- 使用 4 个空格缩进
- 类和方法添加必要的 Javadoc 注释
- 变量名使用驼峰命名法

### 提交信息

遵循 [Conventional Commits](https://www.conventionalcommits.org/) 规范：

- `feat:` 新功能
- `fix:` 修复 bug
- `docs:` 文档更新
- `style:` 代码格式调整
- `refactor:` 代码重构
- `test:` 测试相关
- `chore:` 构建/工具相关

## 🧪 测试

在提交 PR 前，请确保：

```bash
# 运行测试
mvn test

# 构建项目
mvn clean install
```

## 📖 文档

如果你添加了新功能，请更新：

- README.md 中的相关说明
- API 文档
- 必要的代码注释

## 💬 获取帮助

如果你有任何问题，可以：

- 在 [Discussions](../../discussions) 中发起讨论
- 在 Issue 中提问

再次感谢你的贡献！ 🎉
