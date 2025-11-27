# Guía de Despliegue en Render con Blueprint

## 🚀 Pasos para Desplegar en Render

### Paso 1: Preparar el Repositorio en GitHub

1. **Asegúrate de que todos los cambios estén commiteados:**
```bash
git add .
git commit -m "Configure Render Blueprint deployment with Docker"
git push origin master
```

2. **Verifica que estos archivos estén en tu repositorio:**
   - ✅ `render.yaml` (configuración del Blueprint)
   - ✅ `Dockerfile` (instrucciones de construcción)
   - ✅ `.dockerignore` (optimización del build)
   - ✅ `pom.xml` (dependencias Maven)
   - ✅ `src/` (código fuente)

### Paso 2: Crear el Blueprint en Render

1. **Ve a Render Dashboard:**
   - URL: https://dashboard.render.com/

2. **Crear nuevo Blueprint:**
   - Click en "New" → "Blueprint"
   - O ve directamente a: https://dashboard.render.com/select-repo?type=blueprint

3. **Conectar tu repositorio de GitHub:**
   - Si es la primera vez, autoriza a Render a acceder a GitHub
   - Selecciona el repositorio: `mariarealpe/desplieguedef` (o el nombre de tu repo)
   - Rama: `master`

4. **Configurar el Blueprint:**
   - Render detectará automáticamente el archivo `render.yaml`
   - Nombre del Blueprint: `Majo_Migue` (o el que prefieras)
   - Click en "Apply"

### Paso 3: Render Creará Automáticamente

Render leerá el `render.yaml` y creará:

1. **Base de Datos PostgreSQL** (`desplieg-db`):
   - Nombre: bookdb
   - Usuario: bookdb_user
   - Plan: Free
   - Región: Oregon

2. **Servicio Web** (`desplieg-api`):
   - Tipo: Docker
   - Plan: Free
   - Puerto: $PORT (asignado automáticamente)
   - Variables de entorno configuradas automáticamente

### Paso 4: Monitorear el Despliegue

1. **Ver logs del build:**
   - En el dashboard, ve a tu servicio `desplieg-api`
   - Click en "Logs"
   - Deberías ver:
     ```
     ==> Building Docker image...
     ==> Downloading dependencies...
     ==> Compiling application...
     ==> Starting service...
     ```

2. **Esperar a que el status sea "Live":**
   - Tiempo estimado: 5-10 minutos
   - Estado "Building" → "Deploying" → "Live"

### Paso 5: Obtener la URL de tu API

Una vez desplegado, Render te dará una URL como:
```
https://desplieg-api.onrender.com
```

## 📝 Configuración del render.yaml

El archivo `render.yaml` está configurado con:

### Servicio Web:
```yaml
- type: web
  name: desplieg-api
  env: docker                    # Usa Docker para el deployment
  plan: free                     # Plan gratuito
  dockerfilePath: ./Dockerfile   # Ubicación del Dockerfile
  dockerContext: .               # Contexto de build
  region: oregon                 # Región del servidor
  healthCheckPath: /api/books    # Endpoint para health checks
  branch: master                 # Rama a desplegar
  autoDeploy: true              # Auto-deploy en cada push
```

### Variables de Entorno:
```yaml
envVars:
  - key: DATABASE_URL            # URL de PostgreSQL (auto-configurada)
    fromDatabase:
      name: desplieg-db
      property: connectionString
  - key: SPRING_PROFILES_ACTIVE  # Perfil de Spring Boot
    value: prod
  - key: JAVA_OPTS               # Opciones de JVM
    value: -Xmx512m -Xms256m
```

### Base de Datos:
```yaml
- name: desplieg-db
  databaseName: bookdb
  user: bookdb_user
  plan: free
  region: oregon
```

## 🔄 Auto-Deployment

Con `autoDeploy: true`, cada vez que hagas push a la rama `master`:

```bash
git add .
git commit -m "Nueva funcionalidad"
git push origin master
```

Render automáticamente:
1. Detecta el cambio en GitHub
2. Inicia un nuevo build
3. Ejecuta el Dockerfile
4. Despliega la nueva versión

## 🧪 Probar la API Desplegada

Una vez que el servicio esté "Live", prueba con:

### 1. GET - Listar todos los libros
```bash
curl https://desplieg-api.onrender.com/api/books
```

### 2. POST - Crear un nuevo libro
```bash
curl -X POST https://desplieg-api.onrender.com/api/books \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Effective Java",
    "author": "Joshua Bloch",
    "isbn": "978-0134685991",
    "price": 54.99,
    "description": "Best practices for Java programming"
  }'
```

### 3. GET - Obtener un libro por ID
```bash
curl https://desplieg-api.onrender.com/api/books/1
```

### 4. PUT - Actualizar un libro
```bash
curl -X PUT https://desplieg-api.onrender.com/api/books/1 \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Effective Java - 3rd Edition",
    "author": "Joshua Bloch",
    "isbn": "978-0134685991",
    "price": 59.99,
    "description": "Best practices for Java 9, 10, and 11"
  }'
```

### 5. DELETE - Eliminar un libro
```bash
curl -X DELETE https://desplieg-api.onrender.com/api/books/1
```

## 📊 Importar Colección de Postman

Usa el archivo `Book_API.postman_collection.json` incluido:

1. Abre Postman
2. Click en "Import"
3. Selecciona el archivo `Book_API.postman_collection.json`
4. **IMPORTANTE:** Actualiza la variable `{{base_url}}`:
   - Era: `http://localhost:8080`
   - Ahora: `https://desplieg-api.onrender.com`

## 🔍 Troubleshooting

### Error: "Driver org.h2.Driver claims to not accept jdbcUrl"
**Solución:** Ya está arreglado en `DataSourceConfig.java`. Asegúrate de tener los últimos cambios.

### Error: "MalformedInputException: Input length = 1"
**Solución:** Ya está arreglado en `pom.xml` con la configuración de encoding UTF-8.

### El servicio está en "Build failed"
1. Ve a los logs del build
2. Busca el error específico
3. Verifica que:
   - El Dockerfile esté en la raíz del repo
   - El archivo `mvnw` tenga permisos de ejecución
   - Todos los archivos `.properties` estén en UTF-8

### El servicio está en "Deploy failed"
1. Ve a los logs de runtime
2. Verifica que:
   - La base de datos esté en estado "Available"
   - La variable `DATABASE_URL` esté configurada
   - El perfil `prod` esté activo

### La aplicación se reinicia constantemente
- Verifica el health check endpoint: `/api/books`
- Asegúrate de que la aplicación responda en el puerto `$PORT`
- Revisa los logs para ver errores de conexión a la DB

## ⚙️ Configuración Avanzada

### Cambiar la Región del Servidor
Edita `render.yaml`:
```yaml
region: oregon  # Opciones: oregon, frankfurt, singapore, ohio
```

### Ajustar Memoria JVM
Edita `render.yaml`:
```yaml
- key: JAVA_OPTS
  value: -Xmx768m -Xms384m  # Aumentar si necesitas más memoria
```

### Cambiar el Health Check Endpoint
Edita `render.yaml`:
```yaml
healthCheckPath: /actuator/health  # Si usas Spring Boot Actuator
```

## 📈 Limitaciones del Plan Free

- **Servicios Web:**
  - 512 MB RAM
  - 0.1 CPU compartida
  - 750 horas/mes (suficiente para 1 servicio 24/7)
  - Se duerme después de 15 minutos de inactividad
  - Primer request después de dormir: ~30-60 segundos

- **Base de Datos PostgreSQL:**
  - 256 MB RAM
  - 1 GB de almacenamiento
  - Expira después de 90 días (debes crear una nueva)

## 🔐 Seguridad

Render maneja automáticamente:
- ✅ HTTPS/SSL (certificados gratuitos)
- ✅ Variables de entorno encriptadas
- ✅ Conexión segura a la base de datos
- ✅ Firewall y protección DDoS

## 📚 Recursos Adicionales

- [Documentación de Render Blueprints](https://render.com/docs/blueprint-spec)
- [Documentación de Docker en Render](https://render.com/docs/docker)
- [Guía de PostgreSQL en Render](https://render.com/docs/databases)
- [Spring Boot en Render](https://render.com/docs/deploy-spring-boot)

## 🎯 Checklist de Deployment

- [ ] Código commiteado y pusheado a GitHub
- [ ] Archivo `render.yaml` configurado
- [ ] Dockerfile optimizado
- [ ] `.dockerignore` creado
- [ ] Blueprint creado en Render Dashboard
- [ ] Servicio en estado "Live"
- [ ] Base de datos en estado "Available"
- [ ] API probada con Postman o curl
- [ ] Health check funcionando
- [ ] Variables de entorno verificadas

## 🚀 ¡Listo para Producción!

Tu API está ahora desplegada y lista para:
- ✅ Recibir requests HTTPS
- ✅ Persistir datos en PostgreSQL
- ✅ Auto-deploy en cada push
- ✅ Escalar si es necesario
- ✅ Pruebas unitarias e integración

