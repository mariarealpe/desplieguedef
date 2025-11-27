# 🚀 Guía de Despliegue en Render

Esta guía te ayudará a desplegar tu API de libros en Render paso a paso.

## 📋 Prerrequisitos

1. Una cuenta en [GitHub](https://github.com)
2. Una cuenta en [Render](https://render.com) (gratis)
3. Git instalado en tu computadora

---

## 🔧 Paso 1: Subir el Código a GitHub

### 1.1 Inicializar Git (si no está inicializado)
```bash
cd C:\Users\maho4\IdeaProjects\desplieg
git init
```

### 1.2 Agregar archivos al repositorio
```bash
git add .
git commit -m "Initial commit: Book API CRUD"
```

### 1.3 Crear un repositorio en GitHub
1. Ve a https://github.com/new
2. Nombre del repositorio: `book-api-spring-boot`
3. Descripción: "API REST CRUD para gestión de libros con Spring Boot"
4. Selecciona "Public"
5. NO marques ninguna opción adicional (README, .gitignore, license)
6. Haz clic en "Create repository"

### 1.4 Conectar y subir a GitHub
```bash
git remote add origin https://github.com/TU_USUARIO/book-api-spring-boot.git
git branch -M main
git push -u origin main
```

---

## 🌐 Paso 2: Desplegar en Render usando Blueprint

### Opción A: Despliegue Automático con Blueprint (RECOMENDADO)

1. **Ir a Render Dashboard**
   - Ve a https://dashboard.render.com
   - Inicia sesión o crea una cuenta

2. **Crear un Blueprint**
   - Haz clic en "New +" (arriba a la derecha)
   - Selecciona "Blueprint"
   
3. **Conectar GitHub**
   - Conecta tu cuenta de GitHub si aún no lo has hecho
   - Busca y selecciona tu repositorio `book-api-spring-boot`
   - Haz clic en "Connect"

4. **Configurar el Blueprint**
   - Render detectará automáticamente el archivo `render.yaml`
   - Revisa la configuración:
     - Web Service: `desplieg-api`
     - Database: `desplieg-db` (PostgreSQL)
   
5. **Aplicar el Blueprint**
   - Haz clic en "Apply"
   - Render creará automáticamente:
     - La base de datos PostgreSQL
     - El servicio web
     - Configurará las variables de entorno

6. **Esperar el Despliegue**
   - El proceso puede tardar 5-10 minutos
   - Verás los logs de compilación en tiempo real
   - Cuando veas "Build successful" y luego "Live", ¡tu API está lista!

7. **Obtener la URL**
   - La URL será algo como: `https://desplieg-api.onrender.com`
   - Prueba el endpoint de health: `https://desplieg-api.onrender.com/api/books/health`

---

### Opción B: Despliegue Manual (Alternativa)

Si prefieres configurar manualmente:

#### 2.1 Crear Base de Datos PostgreSQL

1. En Render Dashboard, haz clic en "New +"
2. Selecciona "PostgreSQL"
3. Configuración:
   - **Name**: `desplieg-db`
   - **Database**: `bookdb`
   - **User**: `bookuser` (se generará automáticamente)
   - **Region**: Selecciona la más cercana
   - **Plan**: Free
4. Haz clic en "Create Database"
5. **IMPORTANTE**: Copia la "Internal Database URL" (la necesitarás después)

#### 2.2 Crear Web Service

1. Haz clic en "New +" → "Web Service"
2. Conecta tu repositorio de GitHub
3. Configuración:
   - **Name**: `desplieg-api`
   - **Region**: La misma que la base de datos
   - **Branch**: `main`
   - **Root Directory**: dejar vacío
   - **Runtime**: Java
   - **Build Command**: 
     ```
     ./mvnw clean package -DskipTests
     ```
   - **Start Command**: 
     ```
     java -Dserver.port=$PORT -Dspring.profiles.active=prod -jar target/desplieg-0.0.1-SNAPSHOT.jar
     ```
   - **Plan**: Free

4. **Variables de Entorno**:
   - Haz clic en "Advanced"
   - Agrega estas variables:
     - `JAVA_VERSION`: `17`
     - `DATABASE_URL`: (pega la Internal Database URL que copiaste)

5. Haz clic en "Create Web Service"

---

## 🧪 Paso 3: Probar tu API en Render

Una vez desplegada, prueba estos endpoints (reemplaza `TU_URL` con tu URL de Render):

### Health Check
```bash
curl https://TU_URL.onrender.com/api/books/health
```

### Crear un libro
```bash
curl -X POST https://TU_URL.onrender.com/api/books \
  -H "Content-Type: application/json" \
  -d '{"title":"Clean Code","author":"Robert C. Martin","isbn":"978-0132350884","price":45.99,"description":"A Handbook of Agile Software Craftsmanship"}'
```

### Obtener todos los libros
```bash
curl https://TU_URL.onrender.com/api/books
```

---

## 📝 Notas Importantes

### ⚠️ Plan Free de Render
- La aplicación se "duerme" después de 15 minutos de inactividad
- La primera petición después de dormir puede tardar 30-60 segundos
- Tiene 750 horas gratis al mes (suficiente para desarrollo/testing)

### 🔄 Auto-Deploy
- Render automáticamente redespliegará tu app cuando hagas push a `main`
- Cada cambio en GitHub activará un nuevo build

### 📊 Logs
- Puedes ver los logs en tiempo real en el dashboard de Render
- Útil para debugging y monitoreo

### 🗄️ Base de Datos
- La base de datos PostgreSQL FREE tiene:
  - 256 MB de almacenamiento
  - Se elimina después de 90 días de inactividad
  - Ideal para desarrollo y pruebas

---

## 🐛 Solución de Problemas

### Error: Build Failed
- Verifica que el archivo `pom.xml` esté en la raíz del repositorio
- Revisa los logs de build para ver el error específico

### Error: Application Crashed
- Verifica que la variable `DATABASE_URL` esté configurada correctamente
- Asegúrate de que el profile `prod` esté activo

### Error: Cannot Connect to Database
- Verifica que estás usando la "Internal Database URL" (no la External)
- Asegúrate de que la base de datos esté en estado "Available"

### La primera petición es muy lenta
- Esto es normal en el plan free cuando la app está "dormida"
- Considera usar un servicio de "ping" para mantenerla activa (no recomendado para free tier)

---

## 🎯 Próximos Pasos

1. **Configurar un dominio personalizado** (opcional, disponible en Render)
2. **Agregar más pruebas unitarias**
3. **Implementar integración continua** con GitHub Actions
4. **Agregar Swagger/OpenAPI** para documentación interactiva
5. **Implementar seguridad** con Spring Security (JWT)

---

## 📚 Recursos Adicionales

- [Documentación de Render](https://render.com/docs)
- [Render Blueprint Spec](https://render.com/docs/blueprint-spec)
- [Spring Boot en Render](https://render.com/docs/deploy-spring-boot)
- [PostgreSQL en Render](https://render.com/docs/databases)

---

## ✅ Checklist de Despliegue

- [ ] Código subido a GitHub
- [ ] Cuenta de Render creada
- [ ] Blueprint aplicado / Servicios creados manualmente
- [ ] Base de datos PostgreSQL creada
- [ ] Variables de entorno configuradas
- [ ] Build completado exitosamente
- [ ] Aplicación en estado "Live"
- [ ] Endpoint de health respondiendo
- [ ] Pruebas CRUD funcionando

¡Felicidades! 🎉 Tu API está desplegada y lista para usar.

