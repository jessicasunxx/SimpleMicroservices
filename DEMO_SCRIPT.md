# 🎬 SimpleMicroservices Demo Script

## 📋 Pre-Demo Setup (2 minutes)

### **What to Do:**
1. **Open Terminal** and navigate to project directory
2. **Start the server**: `python main.py`
3. **Verify server is running**: Should show "Uvicorn running on http://0.0.0.0:8000"
4. **Open browser** to `http://localhost:8000/docs`
5. **Prepare demo script**: `./demo_commands.sh`

### **What to Say:**
*"Hi, I'm Jessica Sun and this is my Sprint 0 completion demo for the Simple Microservices project. I've built a complete FastAPI microservice with two resources - Person and Address - that includes all required CRUD operations and OpenAPI documentation."*

---

## 🎯 **Demo Part 1: Overview & Architecture (3 minutes)**

### **What to Show:**
1. **Browser**: Go to `http://localhost:8000/docs`
2. **Point out**: "This is the automatically generated OpenAPI documentation"
3. **Show the endpoints list**: "As you can see, I have 15 total endpoints"

### **What to Say:**
*"Let me show you the automatically generated OpenAPI documentation. This demonstrates the 'API-first' approach - the documentation is generated directly from my code annotations. As you can see, I have 15 endpoints total:"*

**Point to each section and say:**
- *"Two health check endpoints for monitoring"*
- *"Complete CRUD operations for Addresses: POST to create, GET to list, GET with ID to retrieve, PUT to replace the entire resource, PATCH for partial updates, and DELETE to remove"*
- *"Complete CRUD operations for Persons with the same full set of operations"*
- *"Plus a root endpoint for basic connectivity"*

*"Notice the color coding - blue for GET, green for POST, orange for PUT, light green for PATCH, and red for DELETE. This follows REST API best practices."*

---

## 🧪 **Demo Part 2: Live API Testing (8 minutes)**

### **What to Do:**
Run the demo script: `./demo_commands.sh`

### **What to Say:**
*"Now let me demonstrate the API with real data. I'll test all the CRUD operations to show that the microservice works correctly."*

### **Test 1: Health Check**
**What Happens:** Script tests health endpoints
**What to Say:** 
*"First, I'm testing the health endpoints. This shows the service is running and provides basic monitoring information including timestamps and IP addresses."*

### **Test 2: Create Operations**
**What Happens:** Script creates a Person and Address
**What to Say:**
*"Now I'm creating a new Person with a Columbia UNI 'demo123', and an Address. Notice how the API validates the UNI format, email format, and generates UUIDs automatically. The response includes server-generated fields like created_at and updated_at timestamps."*

### **Test 3: Read Operations**
**What Happens:** Script lists all persons and addresses
**What to Say:**
*"Let me retrieve all the data. The GET endpoints return JSON arrays with all stored records. Notice how the Person model includes nested Address objects, demonstrating the one-to-many relationship."*

### **Test 4: Get by ID**
**What Happens:** Script gets specific person by ID
**What to Say:**
*"I can also retrieve a specific record by its UUID. This is useful for detailed operations on individual resources."*

### **Test 5: Update Operations**
**What Happens:** Script does PATCH (partial update) and PUT (full replacement)
**What to Say:**
*"Now I'll demonstrate the two types of updates. PATCH allows partial updates - I'm only changing the phone number and addresses. PUT replaces the entire resource - notice how I'm completely replacing the address with new data."*

### **Test 6: Delete Operations**
**What Happens:** Script deletes the person and address
**What to Say:**
*"Finally, I'll delete the records. The DELETE endpoints remove the resources and return a confirmation message. Let me verify the deletion worked by listing the remaining data."*

### **Test 7: Verification**
**What Happens:** Script shows empty lists
**What to Say:**
*"Perfect! The deletion worked correctly - the lists are now empty, confirming that the resources were properly removed."*

---

## 🔍 **Demo Part 3: Key Features Highlight (3 minutes)**

### **What to Show:**
1. **Expand a Person model** in Swagger UI
2. **Show validation examples**
3. **Demonstrate error handling**

### **What to Say:**
*"Let me highlight some key features of my implementation:"*

**Click on Person model in Swagger UI:**
*"The Person model includes Columbia UNI validation with regex patterns, email validation using EmailStr, and nested address relationships. Each field has comprehensive descriptions and examples."*

**Try to create a person with invalid UNI:**
*"Watch what happens when I try to create a person with an invalid UNI format - the API returns a 422 validation error with detailed field-level error messages."*

**Show the Address model:**
*"The Address model uses UUID generation for persistent IDs and includes comprehensive address fields with proper validation."*

---

## 🏗️ **Demo Part 4: Technical Architecture (2 minutes)**

### **What to Show:**
1. **File structure** in terminal: `ls -la`
2. **Key files**: `main.py`, `models/`, `requirements.txt`

### **What to Say:**
*"Let me show you the technical architecture. I followed Professor Ferguson's repository structure with:"*

- *"main.py contains all the FastAPI routes and business logic"*
- *"models/ directory contains Pydantic v2 models with validation"*
- *"requirements.txt specifies all dependencies"*
- *"The project uses proper separation of concerns with models, routes, and configuration"*

---

## 🎯 **Demo Part 5: Sprint Requirements Check (2 minutes)**

### **What to Show:**
1. **Sprint Completion Report**: `Sprint_Completion_Report.md`
2. **GitHub repository**: Show the repo in browser

### **What to Say:**
*"Let me verify that I've met all Sprint 0 requirements:"*

**Check off each requirement:**
- ✅ *"Two different resources - Person and Address"*
- ✅ *"GET /<resource> - List all resources"*
- ✅ *"POST /<resource> - Create new resources"*
- ✅ *"GET /<resource>/{id} - Get specific resource"*
- ✅ *"PUT /<resource>/{id} - Replace entire resource"*
- ✅ *"DELETE /<resource>/{id} - Remove resource"*
- ✅ *"OpenAPI document generation - automatically created"*
- ✅ *"Model annotations with examples and validation"*

*"My implementation actually exceeds the requirements by including PATCH endpoints for partial updates and comprehensive filtering capabilities."*

---

## 🚀 **Demo Part 6: Repository & Next Steps (2 minutes)**

### **What to Show:**
1. **GitHub repository**: `https://github.com/jessicasunxx/SimpleMicroservices.git`
2. **Recent commits** and project structure

### **What to Say:**
*"My complete implementation is available at https://github.com/jessicasunxx/SimpleMicroservices.git. The repository includes:"*

- *"All source code with complete CRUD operations"*
- *"Comprehensive Sprint Completion Report"*
- *"Demo script for testing all endpoints"*
- *"Proper git history showing development progress"*

*"For the next sprint, I plan to add persistent data storage, comprehensive error handling, and authentication mechanisms. The current implementation provides a solid foundation for these enhancements."*

---

## ✅ **Demo Conclusion (1 minute)**

### **What to Say:**
*"In summary, I've successfully completed Sprint 0 by building a fully functional FastAPI microservice with two resources, complete CRUD operations, automatic OpenAPI documentation, and comprehensive validation. The API is production-ready for basic operations and demonstrates professional software development practices."*

*"Thank you for watching my demo. Are there any questions about the implementation or specific features you'd like me to demonstrate further?"*

---

## 📝 **Demo Tips:**

### **Timing:**
- **Total Demo Time**: ~20 minutes
- **Allow 5 minutes for Q&A**
- **Practice the script beforehand**

### **Technical Setup:**
- **Have backup plans**: If demo script fails, use Swagger UI
- **Test everything beforehand**: Make sure server runs smoothly
- **Have sample data ready**: Prepare realistic test data

### **Presentation Tips:**
- **Speak clearly and confidently**
- **Point to specific parts of the screen**
- **Explain the "why" behind technical decisions**
- **Show enthusiasm for the work completed**

### **If Something Goes Wrong:**
- **Stay calm**: "Let me try that again"
- **Have alternatives**: Use Swagger UI if script fails
- **Focus on what works**: Don't get stuck on minor issues

---

## 🎬 **Recording Checklist:**

Before recording, verify:
- [ ] Server starts without errors
- [ ] Demo script runs successfully
- [ ] Browser opens to correct URLs
- [ ] Terminal is visible and readable
- [ ] Audio is clear
- [ ] Screen recording captures everything
- [ ] GitHub repository is accessible
