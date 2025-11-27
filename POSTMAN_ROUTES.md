# 📮 RUTAS PARA POSTMAN - Book API

## 🔗 URL Base
```
http://localhost:8080
```

---

## 📋 TODAS LAS RUTAS (9 Endpoints)

### 1️⃣ HEALTH CHECK
**Verificar que el servicio está funcionando**

```
GET http://localhost:8080/api/books/health
```

**Sin Headers ni Body**

**Respuesta esperada:**
```json
{
  "status": "UP",
  "service": "Book API"
}
```

---

### 2️⃣ OBTENER TODOS LOS LIBROS
**Listar todos los libros**

```
GET http://localhost:8080/api/books
```

**Sin Headers ni Body**

**Respuesta esperada:** Array con todos los libros

---

### 3️⃣ OBTENER LIBRO POR ID
**Obtener un libro específico**

```
GET http://localhost:8080/api/books/1
```

**Cambia el `1` por el ID del libro que quieras obtener**

---

### 4️⃣ OBTENER LIBRO POR ISBN
**Buscar libro por su ISBN**

```
GET http://localhost:8080/api/books/isbn/978-0132350884
```

**Cambia el ISBN por el que quieras buscar**

---

### 5️⃣ BUSCAR POR AUTOR
**Buscar libros que contengan el nombre del autor**

```
GET http://localhost:8080/api/books/search/author?author=Martin
```

**Parámetro Query:**
- `author` = texto a buscar (case-insensitive)

---

### 6️⃣ BUSCAR POR TÍTULO
**Buscar libros que contengan el título**

```
GET http://localhost:8080/api/books/search/title?title=Java
```

**Parámetro Query:**
- `title` = texto a buscar (case-insensitive)

---

### 7️⃣ CREAR NUEVO LIBRO
**Agregar un libro nuevo**

```
POST http://localhost:8080/api/books
```

**Headers:**
```
Content-Type: application/json
```

**Body (raw JSON):**
```json
{
  "title": "Effective Java",
  "author": "Joshua Bloch",
  "isbn": "978-0134685991",
  "price": 52.99,
  "description": "Best Practices for the Java Platform"
}
```

**Respuesta esperada:** El libro creado con su ID asignado

---

### 8️⃣ ACTUALIZAR LIBRO
**Modificar un libro existente**

```
PUT http://localhost:8080/api/books/1
```

**Headers:**
```
Content-Type: application/json
```

**Body (raw JSON):**
```json
{
  "title": "Clean Code - 2nd Edition",
  "author": "Robert C. Martin",
  "isbn": "978-0132350884",
  "price": 49.99,
  "description": "Updated edition with new insights"
}
```

**Cambia el `1` por el ID del libro que quieras actualizar**

---

### 9️⃣ ELIMINAR LIBRO
**Borrar un libro**

```
DELETE http://localhost:8080/api/books/1
```

**Sin Headers ni Body**

**Respuesta esperada:**
```json
{
  "message": "Libro eliminado exitosamente"
}
```

---

## 🎯 EJEMPLOS DE DATOS PARA CREAR LIBROS

### Libro 1 - Effective Java
```json
{
  "title": "Effective Java",
  "author": "Joshua Bloch",
  "isbn": "978-0134685991",
  "price": 52.99,
  "description": "Best Practices for the Java Platform"
}
```

### Libro 2 - Spring in Action
```json
{
  "title": "Spring in Action",
  "author": "Craig Walls",
  "isbn": "978-1617294945",
  "price": 44.99,
  "description": "Covers Spring 5"
}
```

### Libro 3 - Java Concurrency
```json
{
  "title": "Java Concurrency in Practice",
  "author": "Brian Goetz",
  "isbn": "978-0321349606",
  "price": 59.99,
  "description": "Essential techniques for concurrent programming"
}
```

### Libro 4 - Thinking in Java
```json
{
  "title": "Thinking in Java",
  "author": "Bruce Eckel",
  "isbn": "978-0131872486",
  "price": 49.99,
  "description": "Introduction to Object-Oriented Programming"
}
```

---

## 📥 IMPORTAR COLECCIÓN EN POSTMAN

Ya tienes el archivo **`Book_API.postman_collection.json`** listo!

### Pasos para importar:

1. **Abre Postman**
2. **Haz clic en "Import"** (botón arriba a la izquierda)
3. **Selecciona "File"**
4. **Busca y selecciona:** `Book_API.postman_collection.json`
5. **Haz clic en "Import"**

¡Listo! Todas las rutas estarán disponibles en tu colección.

---

## 🔄 FLUJO DE PRUEBA COMPLETO

### Secuencia recomendada:

1. **Health Check** - Verificar que el servidor está corriendo
2. **GET /api/books** - Ver los 5 libros precargados
3. **GET /api/books/1** - Obtener un libro específico
4. **GET /api/books/search/author?author=Martin** - Buscar por autor
5. **POST /api/books** - Crear un nuevo libro
6. **GET /api/books** - Verificar que se agregó
7. **PUT /api/books/6** - Actualizar el libro creado
8. **DELETE /api/books/6** - Eliminar el libro
9. **GET /api/books** - Verificar que se eliminó

---

## ⚠️ VALIDACIONES A PROBAR

### Crear libro sin título (ERROR esperado)
```json
{
  "author": "Test Author",
  "isbn": "123-456",
  "price": 29.99
}
```
**Error esperado:** "El título es obligatorio"

### Crear libro con precio negativo (ERROR esperado)
```json
{
  "title": "Test Book",
  "author": "Test Author",
  "isbn": "123-456",
  "price": -10
}
```
**Error esperado:** "El precio debe ser positivo"

### Crear libro con ISBN duplicado (ERROR esperado)
```json
{
  "title": "Test Book",
  "author": "Test Author",
  "isbn": "978-0132350884",
  "price": 29.99
}
```
**Error esperado:** "Ya existe un libro con el ISBN: 978-0132350884"

---

## 📊 RESPUESTAS DE EJEMPLO

### Respuesta exitosa - Crear Libro
```json
{
  "id": 6,
  "title": "Effective Java",
  "author": "Joshua Bloch",
  "isbn": "978-0134685991",
  "price": 52.99,
  "description": "Best Practices for the Java Platform",
  "createdAt": "2025-11-26T20:15:30",
  "updatedAt": "2025-11-26T20:15:30"
}
```

### Respuesta exitosa - Lista de Libros
```json
[
  {
    "id": 1,
    "title": "Clean Code",
    "author": "Robert C. Martin",
    "isbn": "978-0132350884",
    "price": 45.99,
    "description": "A Handbook of Agile Software Craftsmanship",
    "createdAt": "2025-11-26T20:00:00",
    "updatedAt": "2025-11-26T20:00:00"
  },
  {
    "id": 2,
    "title": "Design Patterns",
    "author": "Gang of Four",
    ...
  }
]
```

### Respuesta de error
```json
{
  "error": "Libro no encontrado con id: 999"
}
```

---

## 🎨 CONFIGURAR ENVIRONMENT EN POSTMAN (Opcional)

Para cambiar fácilmente entre desarrollo y producción:

1. **Crea un Environment** en Postman
2. **Nombre:** `Book API - Local`
3. **Variable:**
   - Key: `baseUrl`
   - Value: `http://localhost:8080`

4. **Luego usa:** `{{baseUrl}}/api/books`

Cuando despliegues en Render, solo cambia el valor de `baseUrl`.

---

## 🚀 ¡LISTO PARA PROBAR!

1. ✅ **Inicia la aplicación** en IntelliJ
2. ✅ **Importa la colección** en Postman
3. ✅ **Empieza con Health Check**
4. ✅ **Prueba todas las rutas**

**¡Disfruta probando tu API!** 🎉

