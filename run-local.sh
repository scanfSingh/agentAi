#!/bin/bash

echo "🚀 Starting Spring Boot Application..."
echo ""

# Check if Maven is installed
if ! command -v mvn &> /dev/null; then
    echo "❌ Maven is not installed. Please install Maven first."
    echo "Visit: https://maven.apache.org/install.html"
    exit 1
fi

# Check Java version
echo "📋 Checking Java version..."
java -version

echo ""
echo "🔨 Building application..."
mvn clean package -DskipTests

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build successful!"
    echo ""
    echo "🏃 Running application..."
    echo "Access the API at: http://localhost:8080"
    echo ""
    echo "Available endpoints:"
    echo "  - http://localhost:8080/api/"
    echo "  - http://localhost:8080/api/hello"
    echo "  - http://localhost:8080/api/status"
    echo "  - http://localhost:8080/actuator/health"
    echo ""
    java -jar target/spring-vercel-app.jar
else
    echo ""
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi

