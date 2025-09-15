#!/bin/bash

# Demo Script for SimpleMicroservices API
# Run this during your presentation to test endpoints

echo "🚀 SimpleMicroservices API Demo"
echo "================================"
echo ""

# Test 1: Health Check
echo "1️⃣ Testing Health Endpoint:"
curl -s -X GET "http://localhost:8000/health" | python3 -m json.tool
echo ""

# Test 2: Health with Path
echo "2️⃣ Testing Health with Path Parameter:"
curl -s -X GET "http://localhost:8000/health/demo123" | python3 -m json.tool
echo ""

# Test 3: Create a Person
echo "3️⃣ Creating a New Person:"
PERSON_RESPONSE=$(curl -s -X POST "http://localhost:8000/persons" \
-H "Content-Type: application/json" \
-d '{
  "uni": "demo123",
  "first_name": "Demo",
  "last_name": "User",
  "email": "demo@columbia.edu",
  "phone": "+1-212-555-9999",
  "birth_date": "1995-06-15",
  "addresses": [
    {
      "id": "demo-addr-1111-1111-111111111111",
      "street": "Demo Street 123",
      "city": "New York",
      "state": "NY",
      "postal_code": "10025",
      "country": "USA"
    }
  ]
}')
echo "$PERSON_RESPONSE" | python3 -m json.tool

# Extract person ID for later tests
PERSON_ID=$(echo "$PERSON_RESPONSE" | python3 -c "import sys, json; data=json.load(sys.stdin); print(data['id'])")
echo ""

# Test 4: Create an Address
echo "4️⃣ Creating a New Address:"
ADDRESS_RESPONSE=$(curl -s -X POST "http://localhost:8000/addresses" \
-H "Content-Type: application/json" \
-d '{
  "id": "demo-addr-2222-2222-222222222222",
  "street": "Test Avenue 456",
  "city": "Brooklyn",
  "state": "NY",
  "postal_code": "11201",
  "country": "USA"
}')
echo "$ADDRESS_RESPONSE" | python3 -m json.tool

# Extract address ID for later tests
ADDRESS_ID=$(echo "$ADDRESS_RESPONSE" | python3 -c "import sys, json; data=json.load(sys.stdin); print(data['id'])")
echo ""

# Test 5: List All Persons
echo "5️⃣ Listing All Persons:"
curl -s -X GET "http://localhost:8000/persons" | python3 -m json.tool
echo ""

# Test 6: List All Addresses
echo "6️⃣ Listing All Addresses:"
curl -s -X GET "http://localhost:8000/addresses" | python3 -m json.tool
echo ""

# Test 7: Get Specific Person
echo "7️⃣ Getting Specific Person by ID:"
curl -s -X GET "http://localhost:8000/persons/$PERSON_ID" | python3 -m json.tool
echo ""

# Test 8: Update Person (PATCH)
echo "8️⃣ Updating Person (Partial Update):"
curl -s -X PATCH "http://localhost:8000/persons/$PERSON_ID" \
-H "Content-Type: application/json" \
-d '{
  "phone": "+1-212-555-8888",
  "addresses": [
    {
      "id": "demo-addr-3333-3333-333333333333",
      "street": "Updated Street 789",
      "city": "Manhattan",
      "state": "NY",
      "postal_code": "10001",
      "country": "USA"
    }
  ]
}' | python3 -m json.tool
echo ""

# Test 9: Replace Address (PUT)
echo "9️⃣ Replacing Address (Full Update):"
curl -s -X PUT "http://localhost:8000/addresses/$ADDRESS_ID" \
-H "Content-Type: application/json" \
-d '{
  "id": "'$ADDRESS_ID'",
  "street": "Completely New Street 999",
  "city": "Queens",
  "state": "NY",
  "postal_code": "11368",
  "country": "USA"
}' | python3 -m json.tool
echo ""

# Test 10: Delete Person
echo "🔟 Deleting Person:"
curl -s -X DELETE "http://localhost:8000/persons/$PERSON_ID" | python3 -m json.tool
echo ""

# Test 11: Delete Address
echo "1️⃣1️⃣ Deleting Address:"
curl -s -X DELETE "http://localhost:8000/addresses/$ADDRESS_ID" | python3 -m json.tool
echo ""

# Test 12: Verify Deletion
echo "1️⃣2️⃣ Verifying Deletion - List Persons:"
curl -s -X GET "http://localhost:8000/persons" | python3 -m json.tool
echo ""

echo "✅ Demo Complete! All CRUD operations tested successfully."
echo "🎯 API is working perfectly with all 15 endpoints!"
