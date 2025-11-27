# Guía de Pruebas de la API Book

## 📌 Endpoints Disponibles

### 1. Health Check
Verifica que el servicio está funcionando.

**Endpoint:** `GET /api/books/health`

**Ejemplo con curl:**
```bash
curl http://localhost:8080/api/books/health
```

**Respuesta esperada:**
```json
{
  "status": "UP",
  "service": "Book API"
}
```

---

### 2. Crear un Libro (POST)
Crea un nuevo libro en el sistema.

**Endpoint:** `POST /api/books`

**Ejemplo con curl:**
```bash
curl -X POST http://localhost:8080/api/books \
  -H "Content-Type: application/json" \
  -d "{\"title\":\"Clean Code\",\"author\":\"Robert C. Martin\",\"isbn\":\"978-0132350884\",\"price\":45.99,\"description\":\"A Handbook of Agile Software Craftsmanship\"}"
```

**Ejemplo con PowerShell:**
```powershell
$body = @{
    title = "Clean Code"
    author = "Robert C. Martin"
    isbn = "978-0132350884"
    price = 45.99
    description = "A Handbook of Agile Software Craftsmanship"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8080/api/books" -Method Post -Body $body -ContentType "application/json"
```

**Respuesta esperada:**
```json
{
  "id": 1,
  "title": "Clean Code",
  "author": "Robert C. Martin",
  "isbn": "978-0132350884",
  "price": 45.99,
  "description": "A Handbook of Agile Software Craftsmanship",
  "createdAt": "2025-11-26T10:30:00",
  "updatedAt": "2025-11-26T10:30:00"
}
```

---

### 3. Obtener Todos los Libros (GET)
Obtiene la lista completa de libros.

**Endpoint:** `GET /api/books`

**Ejemplo con curl:**
```bash
curl http://localhost:8080/api/books
```

**Ejemplo con PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/books" -Method Get
```

---

### 4. Obtener un Libro por ID (GET)
Obtiene un libro específico por su ID.

**Endpoint:** `GET /api/books/{id}`

**Ejemplo con curl:**
```bash
curl http://localhost:8080/api/books/1
```

**Ejemplo con PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/books/1" -Method Get
```

---

### 5. Obtener un Libro por ISBN (GET)
Busca un libro por su ISBN.

**Endpoint:** `GET /api/books/isbn/{isbn}`

**Ejemplo con curl:**
```bash
curl http://localhost:8080/api/books/isbn/978-0132350884
```

**Ejemplo con PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/books/isbn/978-0132350884" -Method Get
```

---

### 6. Buscar Libros por Autor (GET)
Busca libros que contengan el autor especificado.

**Endpoint:** `GET /api/books/search/author?author={nombre}`

**Ejemplo con curl:**
```bash
curl "http://localhost:8080/api/books/search/author?author=Martin"
```

**Ejemplo con PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/books/search/author?author=Martin" -Method Get
```

---

### 7. Buscar Libros por Título (GET)
Busca libros que contengan el título especificado.

**Endpoint:** `GET /api/books/search/title?title={titulo}`

**Ejemplo con curl:**
```bash
curl "http://localhost:8080/api/books/search/title?title=Clean"
```

**Ejemplo con PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/books/search/title?title=Clean" -Method Get
```

---

### 8. Actualizar un Libro (PUT)
Actualiza un libro existente.

**Endpoint:** `PUT /api/books/{id}`

**Ejemplo con curl:**
```bash
curl -X PUT http://localhost:8080/api/books/1 \
  -H "Content-Type: application/json" \
  -d "{\"title\":\"Clean Code - 2nd Edition\",\"author\":\"Robert C. Martin\",\"isbn\":\"978-0132350884\",\"price\":49.99,\"description\":\"Updated edition\"}"
```

**Ejemplo con PowerShell:**
```powershell
$body = @{
    title = "Clean Code - 2nd Edition"
    author = "Robert C. Martin"
    isbn = "978-0132350884"
    price = 49.99
    description = "Updated edition"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8080/api/books/1" -Method Put -Body $body -ContentType "application/json"
```

---

### 9. Eliminar un Libro (DELETE)
Elimina un libro del sistema.

**Endpoint:** `DELETE /api/books/{id}`

**Ejemplo con curl:**
```bash
curl -X DELETE http://localhost:8080/api/books/1
```

**Ejemplo con PowerShell:**
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/books/1" -Method Delete
```

**Respuesta esperada:**
```json
{
  "message": "Libro eliminado exitosamente"
}
```

---

## 🧪 Script de Prueba Completo (PowerShell)

Guarda este script como `test-api.ps1` y ejecútalo con PowerShell:

```powershell
# Script de prueba completo para Book API

$baseUrl = "http://localhost:8080/api/books"

Write-Host "=== Probando Book API ===" -ForegroundColor Green

# 1. Health Check
Write-Host "`n1. Health Check..." -ForegroundColor Yellow
Invoke-RestMethod -Uri "$baseUrl/health" -Method Get

# 2. Crear libro 1
Write-Host "`n2. Creando libro 1..." -ForegroundColor Yellow
$book1 = @{
    title = "Clean Code"
    author = "Robert C. Martin"
    isbn = "978-0132350884"
    price = 45.99
    description = "A Handbook of Agile Software Craftsmanship"
} | ConvertTo-Json

$response1 = Invoke-RestMethod -Uri $baseUrl -Method Post -Body $book1 -ContentType "application/json"
$book1Id = $response1.id
Write-Host "Libro creado con ID: $book1Id" -ForegroundColor Green

# 3. Crear libro 2
Write-Host "`n3. Creando libro 2..." -ForegroundColor Yellow
$book2 = @{
    title = "Design Patterns"
    author = "Gang of Four"
    isbn = "978-0201633610"
    price = 54.99
    description = "Elements of Reusable Object-Oriented Software"
} | ConvertTo-Json

$response2 = Invoke-RestMethod -Uri $baseUrl -Method Post -Body $book2 -ContentType "application/json"
$book2Id = $response2.id
Write-Host "Libro creado con ID: $book2Id" -ForegroundColor Green

# 4. Obtener todos los libros
Write-Host "`n4. Obteniendo todos los libros..." -ForegroundColor Yellow
$allBooks = Invoke-RestMethod -Uri $baseUrl -Method Get
Write-Host "Total de libros: $($allBooks.Count)" -ForegroundColor Green

# 5. Obtener libro por ID
Write-Host "`n5. Obteniendo libro por ID..." -ForegroundColor Yellow
$bookById = Invoke-RestMethod -Uri "$baseUrl/$book1Id" -Method Get
Write-Host "Libro encontrado: $($bookById.title)" -ForegroundColor Green

# 6. Buscar por autor
Write-Host "`n6. Buscando por autor 'Martin'..." -ForegroundColor Yellow
$byAuthor = Invoke-RestMethod -Uri "$baseUrl/search/author?author=Martin" -Method Get
Write-Host "Libros encontrados: $($byAuthor.Count)" -ForegroundColor Green

# 7. Actualizar libro
Write-Host "`n7. Actualizando libro..." -ForegroundColor Yellow
$updateBook = @{
    title = "Clean Code - Updated"
    author = "Robert C. Martin"
    isbn = "978-0132350884"
    price = 49.99
    description = "Updated description"
} | ConvertTo-Json

$updated = Invoke-RestMethod -Uri "$baseUrl/$book1Id" -Method Put -Body $updateBook -ContentType "application/json"
Write-Host "Libro actualizado: $($updated.title)" -ForegroundColor Green

# 8. Eliminar libro
Write-Host "`n8. Eliminando libro..." -ForegroundColor Yellow
$deleted = Invoke-RestMethod -Uri "$baseUrl/$book2Id" -Method Delete
Write-Host $deleted.message -ForegroundColor Green

# 9. Verificar lista final
Write-Host "`n9. Verificando lista final..." -ForegroundColor Yellow
$finalBooks = Invoke-RestMethod -Uri $baseUrl -Method Get
Write-Host "Total de libros restantes: $($finalBooks.Count)" -ForegroundColor Green

Write-Host "`n=== Pruebas completadas ===" -ForegroundColor Green
```

---

## 📦 Datos de Prueba (JSON)

### Libro 1
```json
{
  "title": "Clean Code",
  "author": "Robert C. Martin",
  "isbn": "978-0132350884",
  "price": 45.99,
  "description": "A Handbook of Agile Software Craftsmanship"
}
```

### Libro 2
```json
{
  "title": "Design Patterns",
  "author": "Gang of Four",
  "isbn": "978-0201633610",
  "price": 54.99,
  "description": "Elements of Reusable Object-Oriented Software"
}
```

### Libro 3
```json
{
  "title": "Refactoring",
  "author": "Martin Fowler",
  "isbn": "978-0134757599",
  "price": 47.99,
  "description": "Improving the Design of Existing Code"
}
```

### Libro 4
```json
{
  "title": "The Pragmatic Programmer",
  "author": "Andy Hunt & Dave Thomas",
  "isbn": "978-0135957059",
  "price": 42.99,
  "description": "Your Journey to Mastery"
}
```

---

## 🔍 Validaciones

La API incluye las siguientes validaciones:

- ✅ **Título**: Obligatorio, no puede estar vacío
- ✅ **Autor**: Obligatorio, no puede estar vacío
- ✅ **ISBN**: Obligatorio, único, no puede estar vacío
- ✅ **Precio**: Obligatorio, debe ser un número positivo
- ✅ **Descripción**: Opcional

### Ejemplo de error de validación:
```bash
# Intentar crear un libro con precio negativo
curl -X POST http://localhost:8080/api/books \
  -H "Content-Type: application/json" \
  -d "{\"title\":\"Test\",\"author\":\"Test\",\"isbn\":\"123\",\"price\":-10}"
```

Respuesta:
```json
{
  "error": "El precio debe ser positivo"
}
```

