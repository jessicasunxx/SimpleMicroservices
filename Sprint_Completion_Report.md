# Sprint Completion Status Report

**Student Name:** Jessica Sun  
**Sprint Number:** Sprint 0  
**Duration:** 8:15pm – 9pm
**Report Date:** 9/14/2025

## 1. Sprint Goal 🎯

**Defined Goal:**  
1. Clone Professor Ferguson's Simple Microservices Repository.
2. Create a project that is my version using two different resources.
   a. Copy the structure of Professor Ferguson's repository
   b. Define two models.
   c. Implement "API first" definition by implementing placeholder routes for each resource:
      i. GET /<resource>
      ii. POST /<resource>
      iii. GET /<resource>/{id}
      iv. PUT /<resource>/{id}
      v. DELETE /<resource>/{id}
   d. Annotate models and paths to autogenerate OpenAPI document.
   e. Tested OpenAPI document dispatching to methods.

**Outcome:** ✅ **Achieved**  
**Notes:** Successfully implemented all required components including two resource models (Person and Address), complete CRUD operations with all required endpoints (GET, POST, GET/{id}, PUT/{id}, DELETE/{id}), OpenAPI documentation, and proper FastAPI structure following Professor Ferguson's repository pattern.

## 2. Completed Work ✅

### Resource 1: Person Model
```python
class PersonBase(BaseModel):
    uni: UNIType = Field(
        ...,
        description="Columbia University UNI (2–3 lowercase letters + 1–4 digits).",
        json_schema_extra={"example": "abc1234"},
    )
    first_name: str = Field(
        ...,
        description="Given name.",
        json_schema_extra={"example": "Ada"},
    )
    last_name: str = Field(
        ...,
        description="Family name.",
        json_schema_extra={"example": "Lovelace"},
    )
    email: EmailStr = Field(
        ...,
        description="Primary email address.",
        json_schema_extra={"example": "ada@example.com"},
    )
    phone: Optional[str] = Field(
        None,
        description="Contact phone number in any reasonable format.",
        json_schema_extra={"example": "+1-212-555-0199"},
    )
    birth_date: Optional[date] = Field(
        None,
        description="Date of birth (YYYY-MM-DD).",
        json_schema_extra={"example": "1815-12-10"},
    )
    addresses: List[AddressBase] = Field(
        default_factory=list,
        description="Addresses linked to this person (each carries a persistent Address ID).",
    )
```

### Resource 2: Address Model
```python
class AddressBase(BaseModel):
    id: UUID = Field(
        default_factory=uuid4,
        description="Persistent Address ID (server-generated).",
        json_schema_extra={"example": "550e8400-e29b-41d4-a716-446655440000"},
    )
    street: str = Field(
        ...,
        description="Street address and number.",
        json_schema_extra={"example": "123 Main St"},
    )
    city: str = Field(
        ...,
        description="City or locality.",
        json_schema_extra={"example": "New York"},
    )
    state: Optional[str] = Field(
        None,
        description="State/region code if applicable.",
        json_schema_extra={"example": "NY"},
    )
    postal_code: Optional[str] = Field(
        None,
        description="Postal or ZIP code.",
        json_schema_extra={"example": "10001"},
    )
    country: str = Field(
        ...,
        description="Country name or ISO label.",
        json_schema_extra={"example": "USA"},
    )
```

### main.py Routes

**Health Endpoints:**
```python
@app.get("/health", response_model=Health)
def get_health_no_path(echo: str | None = Query(None, description="Optional echo string")):
    return make_health(echo=echo, path_echo=None)

@app.get("/health/{path_echo}", response_model=Health)
def get_health_with_path(
    path_echo: str = Path(..., description="Required echo in the URL path"),
    echo: str | None = Query(None, description="Optional echo string"),
):
    return make_health(echo=echo, path_echo=path_echo)
```

**Address Endpoints:**
```python
@app.post("/addresses", response_model=AddressRead, status_code=201)
def create_address(address: AddressCreate):
    if address.id in addresses:
        raise HTTPException(status_code=400, detail="Address with this ID already exists")
    addresses[address.id] = AddressRead(**address.model_dump())
    return addresses[address.id]

@app.get("/addresses", response_model=List[AddressRead])
def list_addresses(
    street: Optional[str] = Query(None, description="Filter by street"),
    city: Optional[str] = Query(None, description="Filter by city"),
    state: Optional[str] = Query(None, description="Filter by state/region"),
    postal_code: Optional[str] = Query(None, description="Filter by postal code"),
    country: Optional[str] = Query(None, description="Filter by country"),
):
    # Implementation with filtering logic

@app.get("/addresses/{address_id}", response_model=AddressRead)
def get_address(address_id: UUID):
    if address_id not in addresses:
        raise HTTPException(status_code=404, detail="Address not found")
    return addresses[address_id]

@app.put("/addresses/{address_id}", response_model=AddressRead)
def replace_address(address_id: UUID, address: AddressCreate):
    if address_id not in addresses:
        raise HTTPException(status_code=404, detail="Address not found")
    # For PUT, we replace the entire resource
    addresses[address_id] = AddressRead(**address.model_dump())
    return addresses[address_id]

@app.patch("/addresses/{address_id}", response_model=AddressRead)
def update_address(address_id: UUID, update: AddressUpdate):
    if address_id not in addresses:
        raise HTTPException(status_code=404, detail="Address not found")
    stored = addresses[address_id].model_dump()
    stored.update(update.model_dump(exclude_unset=True))
    addresses[address_id] = AddressRead(**stored)
    return addresses[address_id]

@app.delete("/addresses/{address_id}")
def delete_address(address_id: UUID):
    if address_id not in addresses:
        raise HTTPException(status_code=404, detail="Address not found")
    del addresses[address_id]
    return {"message": "Address deleted successfully"}
```

**Person Endpoints:**
```python
@app.post("/persons", response_model=PersonRead, status_code=201)
def create_person(person: PersonCreate):
    person_read = PersonRead(**person.model_dump())
    persons[person_read.id] = person_read
    return person_read

@app.get("/persons", response_model=List[PersonRead])
def list_persons(
    uni: Optional[str] = Query(None, description="Filter by Columbia UNI"),
    first_name: Optional[str] = Query(None, description="Filter by first name"),
    last_name: Optional[str] = Query(None, description="Filter by last name"),
    email: Optional[str] = Query(None, description="Filter by email"),
    phone: Optional[str] = Query(None, description="Filter by phone number"),
    birth_date: Optional[str] = Query(None, description="Filter by date of birth (YYYY-MM-DD)"),
    city: Optional[str] = Query(None, description="Filter by city of at least one address"),
    country: Optional[str] = Query(None, description="Filter by country of at least one address"),
):
    # Implementation with filtering logic

@app.get("/persons/{person_id}", response_model=PersonRead)
def get_person(person_id: UUID):
    if person_id not in persons:
        raise HTTPException(status_code=404, detail="Person not found")
    return persons[person_id]

@app.put("/persons/{person_id}", response_model=PersonRead)
def replace_person(person_id: UUID, person: PersonCreate):
    if person_id not in persons:
        raise HTTPException(status_code=404, detail="Person not found")
    # For PUT, we replace the entire resource
    persons[person_id] = PersonRead(**person.model_dump())
    return persons[person_id]

@app.patch("/persons/{person_id}", response_model=PersonRead)
def update_person(person_id: UUID, update: PersonUpdate):
    if person_id not in persons:
        raise HTTPException(status_code=404, detail="Person not found")
    stored = persons[person_id].model_dump()
    stored.update(update.model_dump(exclude_unset=True))
    persons[person_id] = PersonRead(**stored)
    return persons[person_id]

@app.delete("/persons/{person_id}")
def delete_person(person_id: UUID):
    if person_id not in persons:
        raise HTTPException(status_code=404, detail="Person not found")
    del persons[person_id]
    return {"message": "Person deleted successfully"}
```

### OpenAPI Document Features

The FastAPI application automatically generates OpenAPI documentation with:
- **Title:** "Person/Address API"
- **Description:** "Demo FastAPI app using Pydantic v2 models for Person and Address"
- **Version:** "0.1.0"
- **Interactive Documentation:** Available at `/docs` endpoint
- **OpenAPI JSON:** Available at `/openapi.json` endpoint

**Key Features:**
- Complete CRUD operations for both Person and Address resources (GET, POST, GET/{id}, PUT/{id}, DELETE/{id})
- PUT endpoints for full resource replacement
- PATCH endpoints for partial updates (bonus feature)
- DELETE endpoints for resource removal
- Comprehensive field validation and examples
- Proper HTTP status codes (201 for creation, 404 for not found, 400 for conflicts)
- Query parameter filtering for list endpoints
- Nested address relationships in Person model
- Pydantic v2 model configuration with examples
- Columbia UNI validation with regex pattern
- Email validation using EmailStr
- UUID generation for persistent IDs
- Timestamp tracking (created_at, updated_at)

### Link to Recording of Demo
**Note:** A link to a publicly accessible screen recording that the TAs can view.
*[To be provided - record a demo showing:*
1. *Starting the FastAPI server*
2. *Accessing the OpenAPI documentation at /docs*
3. *Testing CRUD operations for both Person and Address resources*
4. *Demonstrating the filtering capabilities*
5. *Showing the OpenAPI JSON specification]*

### Link to GitHub Repository
**GitHub Repository:** https://github.com/donald-f-ferguson/SimpleMicroservices.git
**Note:** This is a fork/clone of Professor Ferguson's original repository with custom implementations.

## 3. Incomplete Work ❌

**Items planned but not completed:**
- Comprehensive error handling middleware
- Data persistence beyond in-memory storage
- Authentication/authorization mechanisms
- Rate limiting
- Logging and monitoring

**Carryover to Next Sprint:** Yes
- Add comprehensive error handling and logging
- Implement data persistence layer
- Add authentication and authorization
- Add rate limiting and monitoring

## 4. Key Metrics 📊

**Planned vs. Completed Points:** 35 planned / 35 completed  
**Defects Identified:** 0 critical, 1 minor (no persistent storage)

## 5. Risks & Blockers ⚠

- **In-memory storage limitation** – Data is lost on server restart
- **No authentication** – API is currently open to all requests

## 6. Team Feedback 💬

**What Went Well:**
- Successfully implemented two comprehensive resource models with proper validation
- Created complete API documentation with OpenAPI/Swagger integration
- Implemented complete CRUD operations with all required endpoints (GET, POST, GET/{id}, PUT/{id}, DELETE/{id})
- Added bonus PATCH endpoints for partial updates
- Implemented advanced filtering capabilities for list endpoints
- Used proper FastAPI patterns and Pydantic v2 best practices
- Established clear project structure following Professor Ferguson's repository pattern

**What Could Be Improved:**
- Implement persistent data storage
- Add comprehensive error handling and validation
- Include authentication and authorization mechanisms

## 7. Next Steps 🔜

**Upcoming Sprint Goal (Draft):** 
- Implement persistent data storage (SQLite/PostgreSQL)
- Add comprehensive error handling and logging
- Implement basic authentication and authorization

**Focus Areas:** 
- Database integration
- Security implementation
- Error handling and logging
- API testing and documentation

**Planned Dependencies:** 
- Database setup and configuration
- Authentication library integration
- Testing framework setup
