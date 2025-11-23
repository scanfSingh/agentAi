# Contributing to Spring Boot Vercel App

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## 🚀 Getting Started

1. **Fork the repository**
2. **Clone your fork**
   ```bash
   git clone https://github.com/your-username/agentAi.git
   cd agentAi
   ```
3. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

## 💻 Development Setup

### Prerequisites
- Java 17 or higher
- Maven 3.6+
- Docker (optional, for containerized development)

### Running Locally
```bash
# Using Maven
mvn spring-boot:run

# Using Make
make run

# Using the script
./run-local.sh
```

## 🧪 Testing

Always add tests for new features:

```bash
# Run all tests
mvn test

# Run specific test
mvn test -Dtest=HelloControllerTest

# Run with coverage
mvn test jacoco:report
```

## 📝 Code Style

- Follow standard Java conventions
- Use meaningful variable and method names
- Add comments for complex logic
- Keep methods small and focused

### Example Controller

```java
@RestController
@RequestMapping("/api/users")
public class UserController {
    
    @GetMapping("/{id}")
    public ResponseEntity<User> getUser(@PathVariable Long id) {
        // Implementation
        return ResponseEntity.ok(user);
    }
}
```

## 🔍 Before Submitting

- [ ] Code compiles without errors
- [ ] All tests pass
- [ ] New tests added for new features
- [ ] Code follows project conventions
- [ ] Documentation updated (if needed)
- [ ] No unnecessary dependencies added

## 📤 Submitting Changes

1. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add user authentication endpoint"
   ```

2. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Describe your changes clearly

## 📋 Pull Request Guidelines

### Title Format
- `feat: add new feature`
- `fix: resolve bug`
- `docs: update documentation`
- `test: add tests`
- `refactor: improve code`

### Description Should Include
- What changes were made
- Why they were made
- How to test them
- Any breaking changes

### Example
```markdown
## Changes
- Added user authentication endpoint
- Implemented JWT token generation

## Testing
- Run tests: `mvn test`
- Test endpoint: `curl http://localhost:8080/api/auth/login`

## Breaking Changes
None
```

## 🐛 Reporting Bugs

When reporting bugs, include:
- Java version
- Maven version
- Operating system
- Steps to reproduce
- Expected behavior
- Actual behavior
- Error messages/logs

## 💡 Suggesting Features

When suggesting features:
- Describe the use case
- Explain why it's useful
- Provide examples if possible
- Consider implementation complexity

## 🏗️ Project Structure

```
src/main/java/com/example/springvercel/
├── controller/       # REST controllers
├── service/         # Business logic (add as needed)
├── repository/      # Data access (add as needed)
├── model/           # Domain models (add as needed)
└── config/          # Configuration classes (add as needed)
```

## 🎯 Areas for Contribution

- [ ] Add database integration (JPA, PostgreSQL)
- [ ] Implement authentication (Spring Security, JWT)
- [ ] Add API documentation (Swagger/OpenAPI)
- [ ] Improve error handling
- [ ] Add more comprehensive tests
- [ ] Performance optimizations
- [ ] Additional deployment configurations
- [ ] Monitoring and logging improvements

## 📚 Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Spring Framework Reference](https://docs.spring.io/spring-framework/docs/current/reference/html/)
- [Maven Documentation](https://maven.apache.org/guides/)

## ❓ Questions?

If you have questions:
- Check existing issues
- Review documentation
- Ask in pull request comments

## 📜 Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Help others learn

## 🙏 Thank You!

Your contributions help make this project better for everyone!

---

Happy coding! 🚀

