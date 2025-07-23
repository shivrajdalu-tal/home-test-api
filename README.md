# Home Test API - Karate BDD Testing Framework

[![Java](https://img.shields.io/badge/Java-11%2B-orange)](https://openjdk.org/)
[![Maven](https://img.shields.io/badge/Maven-3.6%2B-blue)](https://maven.apache.org/)
[![Karate](https://img.shields.io/badge/Karate-1.4.1-green)](https://github.com/karatelabs/karate)

Comprehensive BDD testing suite for an Inventory API using Karate framework with Java and Maven.

## Project Structure

```
home-test-api/
├── pom.xml                                           # Maven configuration
├── src/test/
│   ├── java/com/hometest/api/
│   │   └── InventoryApiTest.java                     # JUnit 5 test runner
│   └── resources/
│       ├── features/                                 # Feature files
│       │   ├── inventoryAddSuccess.feature           # Successful item addition
│       │   ├── inventoryAddValidation.feature        # Validation error cases
│       │   └── inventoryRetrieval.feature            # Item retrieval operations
│       ├── testData/                                 # Test data files
│       │   ├── addSuccessTestData.json               # Success scenario data
│       │   ├── addValidationTestData.json            # Validation test data
│       │   └── retrievalTestData.json                # Retrieval test data
│       └── karate-config.js                          # Global configuration
reports
```

## Prerequisites

- **Java 11+** - [Download](https://openjdk.org/install/)
- **Maven 3.6+** - [Download](https://maven.apache.org/download.cgi)
- **Running API Server** - Ensure your Inventory API is running on `http://localhost:3100`
- **IntelliJ IDEA** (recommended) - [Download](https://www.jetbrains.com/idea/)

Verify installations:
```bash
java -version
mvn -version
```

## Configuration

The API base URL is configured in `src/test/resources/karate-config.js`:

```javascript
var config = {
  env: env,
  baseUrl: 'http://localhost:3100/',  // Update with your API URL
  timeout: 30000
}
```

## Test Features

### 🟢 **Inventory Retrieval Tests** (`inventoryRetrieval.feature`)
- **Get all menu items**: Validates inventory structure and required fields
- **Filter by specific ID**: Tests ID-based filtering functionality  
- **Validate specific expected item**: Confirms "Classic Muzzarella" item exists with exact data

### ✅ **Add Item Success Tests** (`inventoryAddSuccess.feature`)
- **Add item with random ID and verify**: Complete end-to-end test that adds an item with random ID and validates it appears in inventory

### ❌ **Add Item Validation Tests** (`inventoryAddValidation.feature`)
- **Duplicate item rejection**: Ensures API rejects duplicate IDs
- **Missing field validation**: Tests all required fields (ID, name, price, image)
- **Comprehensive error handling**: Covers all validation scenarios

## Test Data Organization

| File | Purpose | Content |
|------|---------|---------|
| `addSuccessTestData.json` | Success scenarios | Valid item template for addition |
| `addValidationTestData.json` | Error scenarios | Duplicate items, incomplete data |
| `retrievalTestData.json` | Retrieval tests | Expected item data, filter parameters |

## Quick Start

1. **Ensure API server is running** on `http://localhost:3100`

2. **Build project**:
```bash
mvn clean compile
```

3. **Run all tests**:
```bash
mvn test
```

4. **View results**: Open `target/karate-reports/karate-summary.html`

## Running Tests

### Basic Commands
```bash
# Run all tests
mvn test

# Run with custom URL
mvn test -DbaseUrl=https://your-api-url.com
```

### Test Execution Flow

1. **Background setup** runs for each scenario (URL, headers, test data loading)
2. **Success tests** add items with random IDs and verify retrieval
3. **Validation tests** ensure proper error handling for invalid data
4. **Retrieval tests** validate existing inventory items and filtering

## Reports

After running tests, comprehensive reports are generated:

- **📊 HTML Report**: `target/karate-reports/karate-summary.html` (recommended)
- **📈 Timeline Report**: `target/karate-reports/karate-timeline.html`
- **🏷️ Tags Report**: `target/karate-reports/karate-tags.html`
- **📁 JSON Report**: `target/karate-reports/karate-summary.json`
- **🧪 JUnit XML**: `target/surefire-reports/`

- **📊 Sample Repost is stored as**: `karate-reports/karate-summary.html`


## Key Features

### 🎯 **Dynamic Test Data**
- Random ID generation for unique test items
- Template-based data with variable substitution
- Organized JSON test data files

### 🔍 **Comprehensive Validation**
- Exact field matching with expected values
- Array filtering and item verification
- Proper error status code validation (200, 400)

### 📝 **Detailed Logging**
- Step-by-step execution logs
- Data transformation tracking
- Clear success/failure indicators

## API Endpoints Tested

| Method | Endpoint | Purpose | Scenarios |
|--------|----------|---------|-----------|
| `GET` | `/api/inventory` | Retrieve all items | 3 scenarios |
| `GET` | `/api/inventory/filter?id={id}` | Filter by ID | 1 scenario |
| `POST` | `/api/inventory/add` | Add new item | 6 scenarios |

## Troubleshooting

### Common Issues

**❌ API Server Not Running**:
```bash
# Start your API server first
docker-compose up -d  # or your server start command
```

**❌ Connection timeout**:
```javascript
// In karate-config.js
karate.configure('connectTimeout', 60000);
karate.configure('readTimeout', 60000);
```

**❌ Test data not found**:
```bash
# Verify test data files exist
ls -la src/test/resources/testData/
```

**❌ Build issues**:
```bash
mvn clean
mvn dependency:resolve
mvn test
```

| Dependency | Version | Purpose |
|------------|---------|---------|
| Karate JUnit 5 | 1.4.1 | BDD testing framework |
| JUnit Platform | 1.9.2 | Test platform |
| Maven Surefire | 3.0.0-M9 | Test execution |

## Contributing

1. **Add new scenarios** to appropriate feature files in `src/test/resources/features/`
2. **Update test data** in `src/test/resources/testData/` JSON files
3. **Run tests**: `mvn clean test`
4. **Verify all tests pass** before committing
5. **Update documentation** if adding new test categories

## Best Practices

- ✅ Use descriptive scenario names
- ✅ Organize test data in separate JSON files
- ✅ Add comprehensive logging for debugging
- ✅ Validate both success and error cases
- ✅ Use random data for uniqueness when needed

## Support

- [Karate Documentation](https://github.com/karatelabs/karate)
- [Karate Examples](https://github.com/karatelabs/karate/tree/master/examples)
- Check HTML reports for detailed test results
- Verify API endpoints are accessible at configured base URL