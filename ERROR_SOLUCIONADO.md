# ✅ ERROR SOLUCIONADO - data.sql vacío

## 🔴 Error Encontrado

Al ejecutar la aplicación, aparecía este error:

```
Caused by: java.lang.IllegalArgumentException: 'script' must not be null or empty
Failed to execute database script from resource [file [C:\Users\maho4\IdeaProjects\desplieg\target\classes\data.sql]]
```

## 🔍 Causa del Problema

El archivo **`data.sql`** estaba **vacío** en la carpeta `target/classes/`.

Spring Boot intenta ejecutar este archivo para insertar datos iniciales en la base de datos H2, pero al estar vacío, genera un error de validación.

## ✅ Solución Aplicada

1. **Archivo recreado** con datos iniciales de 5 libros
2. **Copiado a la carpeta target/classes** para que Spring Boot lo encuentre

## 📝 Contenido del archivo data.sql

El archivo ahora contiene 5 libros de ejemplo:

```sql
-- Datos iniciales para la tabla de libros
INSERT INTO books (title, author, isbn, price, description, created_at, updated_at) VALUES
('Clean Code', 'Robert C. Martin', '978-0132350884', 45.99, 'A Handbook of Agile Software Craftsmanship', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Design Patterns', 'Gang of Four', '978-0201633610', 54.99, 'Elements of Reusable Object-Oriented Software', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Refactoring', 'Martin Fowler', '978-0134757599', 47.99, 'Improving the Design of Existing Code', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('The Pragmatic Programmer', 'Andy Hunt & Dave Thomas', '978-0135957059', 42.99, 'Your Journey to Mastery', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Head First Java', 'Kathy Sierra & Bert Bates', '978-0596009205', 39.99, 'A Brain-Friendly Guide', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
```

## 🚀 Próximos Pasos

### Ahora puedes ejecutar la aplicación:

**En IntelliJ:**
1. Haz clic derecho en `DespliegApplication.java`
2. Selecciona "Run 'DespliegApplication'"

**Resultado esperado:**
```
Started DespliegApplication in X seconds
```

### Verificar que funciona:

1. **Abre tu navegador:**
   ```
   http://localhost:8080/api/books/health
   ```
   
   Deberías ver:
   ```json
   {
     "status": "UP",
     "service": "Book API"
   }
   ```

2. **Ver todos los libros precargados:**
   ```
   http://localhost:8080/api/books
   ```
   
   Deberías ver los 5 libros que insertamos

3. **Acceder a la consola H2:**
   ```
   http://localhost:8080/h2-console
   ```
   
   Credenciales:
   - JDBC URL: `jdbc:h2:mem:bookdb`
   - Usuario: `sa`
   - Password: (dejar vacío)

## 📌 Nota Importante

**Si vuelves a compilar el proyecto** con Maven desde IntelliJ (Build > Rebuild Project), el archivo se copiará automáticamente de `src/main/resources/` a `target/classes/`.

## ✨ Estado Actual

- ✅ Archivo `data.sql` corregido en `src/main/resources/`
- ✅ Archivo `data.sql` copiado a `target/classes/`
- ✅ Listo para ejecutar la aplicación
- ✅ 5 libros se insertarán automáticamente al iniciar

---

**¡El error está solucionado! Ahora puedes ejecutar la aplicación sin problemas.** 🎉

