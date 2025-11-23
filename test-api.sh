#!/bin/bash

# API Testing Script
# This script tests all endpoints of the Spring Boot application

BASE_URL="${1:-http://localhost:8080}"
echo "🧪 Testing Spring Boot API at: $BASE_URL"
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counter
PASSED=0
FAILED=0

# Function to test an endpoint
test_endpoint() {
    local name=$1
    local method=$2
    local endpoint=$3
    local data=$4
    
    echo -e "${BLUE}Testing: $name${NC}"
    echo "Endpoint: $method $endpoint"
    
    if [ "$method" = "GET" ]; then
        response=$(curl -s -w "\n%{http_code}" "$BASE_URL$endpoint")
    elif [ "$method" = "POST" ]; then
        response=$(curl -s -w "\n%{http_code}" -X POST "$BASE_URL$endpoint" \
            -H "Content-Type: application/json" \
            -d "$data")
    fi
    
    # Extract HTTP status code (last line)
    http_code=$(echo "$response" | tail -n1)
    # Extract body (all but last line)
    body=$(echo "$response" | sed '$d')
    
    echo "Status: $http_code"
    echo "Response:"
    echo "$body" | jq '.' 2>/dev/null || echo "$body"
    
    if [ "$http_code" = "200" ]; then
        echo -e "${GREEN}✅ PASSED${NC}"
        ((PASSED++))
    else
        echo -e "${RED}❌ FAILED${NC}"
        ((FAILED++))
    fi
    echo "---"
    echo ""
}

# Check if server is running
echo "Checking if server is running..."
if ! curl -s -f "$BASE_URL/actuator/health" > /dev/null; then
    echo -e "${RED}❌ Server is not running at $BASE_URL${NC}"
    echo "Please start the server first:"
    echo "  mvn spring-boot:run"
    echo "  OR"
    echo "  ./run-local.sh"
    exit 1
fi
echo -e "${GREEN}✅ Server is running${NC}"
echo ""

# Run tests
echo "========================================="
echo "Running API Tests"
echo "========================================="
echo ""

# Test 1: Root endpoint
test_endpoint "Root Endpoint" "GET" "/api/"

# Test 2: Hello endpoint
test_endpoint "Hello Endpoint" "GET" "/api/hello"

# Test 3: Status endpoint
test_endpoint "Status Endpoint" "GET" "/api/status"

# Test 4: Greet endpoint
test_endpoint "Greet Endpoint" "GET" "/api/greet/Developer"

# Test 5: Echo endpoint
test_endpoint "Echo Endpoint" "POST" "/api/echo" '{"message":"Hello World","test":"data"}'

# Test 6: Health check
test_endpoint "Health Check" "GET" "/actuator/health"

# Summary
echo "========================================="
echo "Test Summary"
echo "========================================="
echo -e "Total Tests: $((PASSED + FAILED))"
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}❌ Some tests failed${NC}"
    exit 1
fi

