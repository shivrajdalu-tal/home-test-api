# Home Test API - Karate BDD Testing Framework

[![Java](https://img.shields.io/badge/Java-11%2B-orange)](https://openjdk.org/)
[![Maven](https://img.shields.io/badge/Maven-3.6%2B-blue)](https://maven.apache.org/)
[![Karate](https://img.shields.io/badge/Karate-1.4.1-green)](https://github.com/karatelabs/karate)
[![JUnit 5](https://img.shields.io/badge/JUnit-5.9.2-yellow)](https://junit.org/junit5/)

This project implements BDD (Behavior Driven Development) testing for an Inventory API using Karate framework with Java and Maven.

## 📋 Table of Contents

- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [API Configuration](#-api-configuration)
- [Test Scenarios Covered](#-test-scenarios-covered)
- [Building the Project](#-building-the-project)
- [Running the Tests](#-running-the-tests)
- [Configuration Options](#-configuration-options)
- [Test Reports](#-test-reports)
- [Troubleshooting](#-troubleshooting)
- [Continuous Integration](#-continuous-integration)
- [Contributing](#-contributing)
- [Dependencies](#-dependencies)

## 📁 Project Structure

```
home-test-api/
├── pom.xml                                    # Maven configuration with Karate dependencies
├── README.md                                  # This file
├── src/
│   └── test/
│       ├── java/
│       │   └── com/hometest/api/
│       │       └── InventoryApiTest.java      # JUnit 5 test runner
│       └── resources/
│           ├── application.properties         # Test application configuration
│           ├── features/
│           │   └── inventory-api.feature      # Gherkin test scenarios
│           ├── karate-config.js               # Karate configuration
│           └── test-data.json                 # Test data for scenarios
└── target/                                    # Generated after build
    ├── karate-reports/                        # HTML test reports
    ├── surefire-reports/                      # JUnit XML reports
    └── test-classes/                          # Compiled test classes
```

## ⚡ Prerequisites

- **Java 11 or higher** - Download from [OpenJDK](https://openjdk.org/install/) or [Oracle](https://www.oracle.com/java/technologies/downloads/)
- **Maven 3.6+** - Download from [Apache Maven](https://maven.apache.org/download.cgi)
- **IntelliJ IDEA** (recommended) - Download from [JetBrains](https://www.jetbrains.com/idea/) - Community Edition is sufficient
- **Git** (optional) - For version control

### ✅ Verify installations:
```bash
java -version
mvn -version
```

## ⚙️ API Configuration

Before running the tests, update the base URL in `src/test/resources/karate-config.js`:

```javascript
// Update these URLs to point to your actual API endpoints
if (env == 'dev') {
  config.baseUrl = 'http://localhost:3100/';  // Replace with your API URL
}
```

## 🧪 Test Scenarios Covered

The test suite validates the following API endpoints and scenarios:

### 1. **Get All Menu Items** 📋
- **Endpoint**: `GET /api/inventory`
- **Validations**:
  - Response contains at least 9 items
  - Each item has required fields: `id`, `name`, `price`, `image`

### 2. **Filter by ID** 🔍
- **Endpoint**: `GET /api/inventory/filter?id=3`
- **Validations**:
  - Returns correct item data for "Baked Rolls x 8"
  - Validates all required fields are present

### 3. **Add New Item (Success)** ✅
- **Endpoint**: `POST /api/inventory/add`
- **Body**: `{"id": "10", "name": "Hawaiian", "image": "hawaiian.png", "price": "$14"}`
- **Validation**: Status code 200

### 4. **Add Existing Item (Failure)** ❌
- **Endpoint**: `POST /api/inventory/add`
- **Body**: Same as above (duplicate ID)
- **Validation**: Status code 400

### 5. **Add Item with Missing Data** ⚠️
- **Endpoint**: `POST /api/inventory/add`
- **Scenarios**: Missing `id`, `name`, `price`, or `image`
- **Validations**:
  - Status code 400
  - Response contains "Not all requirements are met"

### 6. **Verify Added Item in Inventory** ✔️
- **Endpoint**: `GET /api/inventory`
- **Validation**: Confirms the Hawaiian item was successfully added with correct data

## 🔨 Building the Project

1. **Clone or navigate to the project directory**:
```bash
cd home-test-api
```

2. **Download dependencies**:
```bash
mvn clean compile
```

3. **Compile test classes**:
```bash
mvn test-compile
```

## 🚀 Running the Tests

### Run All Tests
```bash
mvn test
```

### Run Tests with Specific Environment
```bash
# For development environment
mvn test -Dkarate.env=dev

# For QA environment
mvn test -Dkarate.env=qa

# For production environment
mvn test -Dkarate.env=prod
```

### Run Tests with Custom Base URL
```bash
mvn test -DbaseUrl=https://your-custom-api-url.com
```

### Run with Detailed Output
```bash
mvn test -Dkarate.options="--tags ~@ignore" -X
```

### Generate HTML Test Report
```bash
mvn test
```
The HTML report will be generated in `target/karate-reports/karate-summary.html`

## 🎛️ Karate Options

### Running Specific Scenarios
Add tags to scenarios in the feature file and run:
```bash
mvn test -Dkarate.options="--tags @smoke"
```

### Parallel Execution
For faster execution with multiple threads:
```bash
mvn test -Dkarate.options="--threads 5"
```

## ⚙️ Configuration Options

### Environment Variables
Set these in your environment or pass as system properties:

- `karate.env` - Environment (dev/qa/prod)
- `baseUrl` - API base URL override
- `karate.options` - Additional Karate options

### karate-config.js Settings
- **Timeouts**: Connection and read timeouts (default: 30 seconds)
- **Headers**: Default Content-Type and other headers
- **Environment URLs**: Different base URLs per environment

### Test Data Configuration
The `test-data.json` file contains sample data used in test scenarios. You can modify this file to customize test data for your specific API requirements.

## 📊 Test Reports

After running tests, you can access various types of reports:

### HTML Reports (Recommended) 🌐
- **Location**: `target/karate-reports/karate-summary.html`
- **Features**: Interactive timeline, detailed scenario results, screenshots
- **Access**: Open in any web browser

### JSON Reports 📄
- **Location**: `target/karate-reports/karate-summary.json`
- **Use**: For CI/CD integration and custom reporting

### JUnit XML Reports 📋
- **Location**: `target/surefire-reports/`
- **Use**: For Maven Surefire plugin and CI/CD systems

### Console Output 💻
- Real-time test execution logs with pass/fail status

## 🔧 Troubleshooting

### Common Issues

1. **Connection Timeout** ⏱️:
   - Increase timeout in `karate-config.js`
   - Check if API URL is accessible
   ```javascript
   configure.connectTimeout = 60000;
   configure.readTimeout = 60000;
   ```

2. **SSL Certificate Issues** 🔒:
   ```bash
   mvn test -Dkarate.options="--ssl false"
   ```

3. **Maven Dependencies** 📦:
   ```bash
   mvn dependency:resolve
   mvn clean install
   ```

4. **Java Version Issues** ☕:
   - Ensure Java 11+ is installed and JAVA_HOME is set correctly
   ```bash
   echo $JAVA_HOME  # On Unix/Mac
   echo %JAVA_HOME% # On Windows
   ```

### Debug Mode 🐛
Run with debug information:
```bash
mvn test -Dkarate.options="--debug" -X
```

### Clean Build 🧹
If you encounter build issues:
```bash
mvn clean
mvn clean compile test-compile
mvn test
```

## 🔄 Continuous Integration

For CI/CD pipelines, use:
```bash
mvn clean test -Dkarate.env=qa -Dmaven.test.failure.ignore=false
```

### Jenkins/GitHub Actions Example
```yaml
- name: Run API Tests
  run: |
    mvn clean test -Dkarate.env=qa
    
- name: Publish Test Results
  uses: dorny/test-reporter@v1
  if: success() || failure()
  with:
    name: Karate Tests
    path: target/surefire-reports/*.xml
    reporter: java-junit
```

## 🤝 Contributing

1. Add new test scenarios to `src/test/resources/features/inventory-api.feature`
2. Update test data in `src/test/resources/test-data.json` if needed
3. Update base URLs in `karate-config.js` as needed
4. Run tests locally before committing:
   ```bash
   mvn clean test
   ```
5. Ensure all tests pass in the target environment
6. Update documentation for new features

## 📦 Dependencies

| Dependency | Version | Purpose |
|------------|---------|---------|
| **Karate** | 1.4.1 | BDD testing framework |
| **JUnit 5** | 5.9.2 | Test runner |
| **Maven Surefire** | 3.0.0-M9 | Test execution plugin |

## 📞 Support

For issues or questions:

1. **Check Test Reports**: Review the HTML report in `target/karate-reports/karate-summary.html`
2. **Console Logs**: Check detailed error messages in console output
3. **API Accessibility**: Verify API endpoints are accessible and responding
4. **Documentation**: Review [Karate Documentation](https://github.com/karatelabs/karate)
5. **Issues**: Create an issue in this repository with:
   - Error message
   - Test scenario that failed
   - Environment details
   - Steps to reproduce

---

**Happy Testing! 🎉**