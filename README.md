# Book API - Spring Boot CRUD

API REST simple para gestionar libros, diseñada para aprender pruebas unitarias y despliegue en Render.

## 🚀 Características

- **CRUD completo** para libros
- **Validaciones** de datos
- **Base de datos H2** para desarrollo (en memoria)
- **PostgreSQL** para producción (Render)
- **Pruebas unitarias** completas con JUnit y Mockito
- **Listo para desplegar** en Render como Blueprint

## 📋 Tecnologías

- Java 17
- Spring Boot 4.0.0
- Spring Data JPA
- H2 Database (desarrollo)
- PostgreSQL (producción)
- Lombok
- JUnit 5 & Mockito (testing)
- Maven

## 🛠️ Instalación y Ejecución Local

### Prerrequisitos
- JDK 17 o superior
- Maven 3.6+

### Pasos

1. **Clonar el repositorio**
```bash
git clone <tu-repositorio>
cd desplieg
```

2. **Compilar el proyecto**
```bash
./mvnw clean install
```

3. **Ejecutar la aplicación**
```bash
./mvnw spring-boot:run
```

La aplicación estará disponible en: `http://localhost:8080`

## 🧪 Ejecutar Pruebas Unitarias

```bash
./mvnw test
```

Para ver el reporte de cobertura:
```bash
./mvnw test jacoco:report
```

## 📚 Endpoints de la API

### Salud del servicio
```http
GET /api/books/health
```

### Obtener todos los libros
```http
GET /api/books
```

### Obtener libro por ID
```http
GET /api/books/{id}
```

### Obtener libro por ISBN
```http
GET /api/books/isbn/{isbn}
```

### Buscar libros por autor
```http
GET /api/books/search/author?author=Martin
```

### Buscar libros por título
```http
GET /api/books/search/title?title=Clean
```

### Crear un nuevo libro
```http
POST /api/books
Content-Type: application/json

{
  "title": "Clean Code",
  "author": "Robert C. Martin",
  "isbn": "978-0132350884",
  "price": 45.99,
  "description": "A Handbook of Agile Software Craftsmanship"
}
```

### Actualizar un libro
```http
PUT /api/books/{id}
Content-Type: application/json

{
  "title": "Clean Code - Updated",
  "author": "Robert C. Martin",
  "isbn": "978-0132350884",
  "price": 49.99,
  "description": "Updated description"
}
```

### Eliminar un libro
```http
DELETE /api/books/{id}
```

## 🗄️ Consola H2 (solo desarrollo)

Accede a la consola H2 en: `http://localhost:8080/h2-console`

- **JDBC URL**: `jdbc:h2:mem:bookdb`
- **Usuario**: `sa`
- **Contraseña**: (dejar vacío)

## 🌐 Despliegue

### Render (Recomendado)

Este proyecto está listo para desplegarse en Render como Blueprint.

**Inicio Rápido:**
1. Sube tu código a GitHub
2. Conecta tu repositorio en [Render](https://dashboard.render.com)
3. Selecciona "Blueprint" - Render detectará automáticamente el `render.yaml`
4. ¡Haz clic en "Apply" y listo!

📖 **Ver guía completa:** [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)

### Otras Plataformas

El proyecto también puede desplegarse en:
- **Heroku** - Ajusta el `Procfile` según sea necesario
- **Railway** - Compatible directamente
- **AWS Elastic Beanstalk** - Requiere configuración adicional
- **Google Cloud Run** - Usar Docker

---

## 📝 Modelo de Datos

### Book Entity
```java
{
  "id": Long,
  "title": String,
  "author": String,
  "isbn": String (único),
  "price": Double,
  "description": String,
  "createdAt": LocalDateTime,
  "updatedAt": LocalDateTime
}
```

## 🧪 Ejemplos de Pruebas

El proyecto incluye pruebas unitarias completas para el servicio `BookService`:

- ✅ Obtener todos los libros
- ✅ Obtener libro por ID (existe y no existe)
- ✅ Obtener libro por ISBN
- ✅ Crear libro (exitoso y con ISBN duplicado)
- ✅ Actualizar libro (existe y no existe)
- ✅ Eliminar libro (existe y no existe)
- ✅ Buscar por autor
- ✅ Buscar por título

## 🤝 Contribuir

Este proyecto es para fines educativos. Siéntete libre de hacer fork y experimentar.

## 📄 Licencia

MIT License

## 👨‍💻 Autor

Proyecto de aprendizaje para pruebas unitarias y despliegue en Render.

