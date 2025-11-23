# Spring Boot Application for Cloud Deployment

A modern Spring Boot REST API application optimized for cloud deployment.

## 🚨 Important Note About Vercel

**Vercel does not natively support Spring Boot (Java) applications.** Vercel is optimized for:
- Frontend frameworks (Next.js, React, Vue, etc.)
- Serverless functions (Node.js, Python, Go, Ruby)

While this application is ready for deployment, **we recommend using alternative platforms** that better support Spring Boot:

### Recommended Deployment Platforms:

1. **Railway** ⭐ (Easiest)
   - Native Spring Boot support
   - Free tier available
   - Simple deployment

2. **Render**
   - Free tier available
   - Docker support
   - Easy setup

3. **AWS Elastic Beanstalk**
   - Scalable
   - AWS ecosystem integration

4. **Heroku**
   - Simple deployment
   - Good for prototypes

5. **Google Cloud Run**
   - Container-based
   - Pay per use

## 🚀 Quick Start (Local Development)

### Prerequisites
- Java 17 or higher
- Maven 3.6+ or use included wrapper

### Run Locally

```bash
# Using Maven
mvn spring-boot:run

# Or using Maven wrapper (if available)
./mvnw spring-boot:run

# Or build and run the JAR
mvn clean package
java -jar target/spring-vercel-app.jar
```

The application will start at `http://localhost:8080`

## 📋 API Endpoints

### Available Endpoints:

- **GET** `/api/` - Welcome message with available endpoints
- **GET** `/api/hello` - Simple hello message
- **GET** `/api/status` - Application status
- **GET** `/api/greet/{name}` - Personalized greeting
- **POST** `/api/echo` - Echo back the request body
- **GET** `/actuator/health` - Health check endpoint

### Example Requests:

```bash
# Get hello message
curl http://localhost:8080/api/hello

# Get personalized greeting
curl http://localhost:8080/api/greet/John

# Echo endpoint
curl -X POST http://localhost:8080/api/echo \
  -H "Content-Type: application/json" \
  -d '{"message": "Hello World"}'

# Health check
curl http://localhost:8080/actuator/health
```

## 🐳 Docker Deployment

This application includes a multi-stage Dockerfile for containerized deployment.

```bash
# Build the Docker image
docker build -t spring-vercel-app .

# Run the container
docker run -p 8080:8080 spring-vercel-app

# Run with environment variables
docker run -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=prod \
  spring-vercel-app
```

## 🚂 Deploy to Railway (Recommended)

Railway is the easiest platform for Spring Boot deployment:

1. Install Railway CLI:
```bash
npm install -g railway
```

2. Login and deploy:
```bash
railway login
railway init
railway up
```

3. Your app will be deployed with a public URL!

### Or use Railway GUI:
1. Visit [railway.app](https://railway.app)
2. Connect your GitHub repository
3. Railway will auto-detect Spring Boot and deploy

## 🎨 Deploy to Render

1. Create a `render.yaml` in your project (already included if you added it)
2. Push to GitHub
3. Visit [render.com](https://render.com)
4. Create new "Web Service"
5. Connect your repository
6. Render will auto-detect and deploy

## ☁️ Deploy to Google Cloud Run

```bash
# Build and push to Google Container Registry
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/spring-vercel-app

# Deploy to Cloud Run
gcloud run deploy spring-vercel-app \
  --image gcr.io/YOUR_PROJECT_ID/spring-vercel-app \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

## 📦 Project Structure

```
.
├── src/
│   └── main/
│       ├── java/com/example/springvercel/
│       │   ├── SpringVercelApplication.java
│       │   └── controller/
│       │       └── HelloController.java
│       └── resources/
│           ├── application.properties
│           └── application-prod.properties
├── pom.xml
├── Dockerfile
├── .dockerignore
├── .gitignore
└── README.md
```

## 🛠️ Technology Stack

- **Java 17** - Programming language
- **Spring Boot 3.2.0** - Application framework
- **Spring Web** - REST API
- **Spring Actuator** - Health checks and monitoring
- **Maven** - Build tool
- **Lombok** - Reduce boilerplate code

## ⚙️ Configuration

### Environment Variables

- `PORT` - Server port (default: 8080)
- `SPRING_PROFILES_ACTIVE` - Active profile (dev/prod)

### Profiles

- **default** - Development settings with debug logging
- **prod** - Production settings with optimized logging

## 🧪 Testing

```bash
# Run tests
mvn test

# Run tests with coverage
mvn test jacoco:report
```

## 📝 Adding New Endpoints

1. Create a new controller in `src/main/java/com/example/springvercel/controller/`
2. Add `@RestController` and `@RequestMapping` annotations
3. Create your endpoint methods

Example:

```java
@RestController
@RequestMapping("/api/users")
public class UserController {
    
    @GetMapping("/{id}")
    public User getUser(@PathVariable Long id) {
        // Your logic here
        return user;
    }
}
```

## 🔒 Security Notes

- CORS is enabled for all origins in development
- Consider restricting CORS in production
- Use environment variables for sensitive data
- The Docker image runs as non-root user

## 🐛 Troubleshooting

### Application won't start
- Check Java version: `java -version` (should be 17+)
- Check Maven version: `mvn -version`
- Clean and rebuild: `mvn clean install`

### Port already in use
```bash
# Change port in application.properties or use environment variable
export PORT=9090
java -jar target/spring-vercel-app.jar
```

## 📚 Additional Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Railway Documentation](https://docs.railway.app/)
- [Render Documentation](https://render.com/docs)
- [Docker Documentation](https://docs.docker.com/)

## 📄 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

---

**Note**: If you absolutely need to deploy on Vercel, consider:
1. Using Vercel's Node.js serverless functions instead of Spring Boot
2. Using Vercel for frontend and deploying this Spring Boot API elsewhere
3. Using Vercel's Edge Network with a backend hosted on Railway/Render

