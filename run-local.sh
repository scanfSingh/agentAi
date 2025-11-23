#!/bin/bash

echo "🚀 Starting Spring Boot Application..."
echo ""

# Check if gradlew exists
if [ ! -f "./gradlew" ]; then
    echo "❌ Gradle wrapper not found. Please ensure gradlew exists."
    exit 1
fi

# Make gradlew executable if it isn't
chmod +x ./gradlew

# Check Java version
echo "📋 Checking Java version..."
java -version

echo ""
echo "🔨 Building application..."
./gradlew build -x test

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
    java -jar build/libs/spring-vercel-app.jar
else
    echo ""
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi

