# ✅ SOLUCIÓN - Error "invalid runtime java"

## 🔴 Error Encontrado

Al intentar usar Blueprint en Render, apareció:
```
services[0].runtime
invalid runtime java
```

## 🔍 Causa

Render **NO acepta** `runtime: java` en el archivo `render.yaml`.

Para aplicaciones Java, Render requiere usar **Docker**.

## ✅ Solución Aplicada

He configurado el proyecto para usar **Docker**:

### 1. Creado `Dockerfile` ✅
- Build multi-stage (optimizado)
- Java 17 (JRE Alpine - imagen ligera)
- Usa variable PORT de Render
- Perfil prod automático

### 2. Actualizado `render.yaml` ✅
- Cambiado a `env: docker`
- Eliminado `buildCommand` y `startCommand` (Docker los maneja)
- Simplificado configuración

### 3. Creado `.dockerignore` ✅
- Evita copiar archivos innecesarios
- Optimiza el build

---

## 🚀 AHORA DEBES HACER

### 1️⃣ Hacer Commit y Push de los Nuevos Archivos

```bash
# En la carpeta del proyecto
cd C:\Users\maho4\IdeaProjects\desplieg

# Agregar los nuevos archivos
git add Dockerfile
git add .dockerignore
git add render.yaml

# Hacer commit
git commit -m "Add Docker support for Render deployment"

# Subir a GitHub
git push origin main
```

⚠️ **IMPORTANTE:** Si ya subiste antes, haz push a la rama `master`:
```bash
git push origin master
```

---

### 2️⃣ Volver a Render y Aplicar el Blueprint

1. **Refresca la página** en Render
2. O vuelve a: https://dashboard.render.com
3. **New +** → **Blueprint**
4. Selecciona tu repo: `mariarealpe/desplieguedef`
5. Ahora debería funcionar ✅

---

## 📋 Archivos Creados/Modificados

### ✅ Archivo: `Dockerfile`
```dockerfile
FROM eclipse-temurin:17-jdk-alpine as build
WORKDIR /app
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B
COPY src src
RUN ./mvnw package -DskipTests

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/desplieg-0.0.1-SNAPSHOT.jar app.jar
EXPOSE ${PORT:-8080}
ENTRYPOINT ["sh", "-c", "java -Dserver.port=${PORT:-8080} -Dspring.profiles.active=prod -jar app.jar"]
```

### ✅ Archivo: `render.yaml` (actualizado)
```yaml
services:
  - type: web
    name: desplieg-api
    env: docker
    plan: free
    envVars:
      - key: DATABASE_URL
        fromDatabase:
          name: desplieg-db
          property: connectionString

databases:
  - name: desplieg-db
    databaseName: bookdb
    plan: free
```

### ✅ Archivo: `.dockerignore`
```
target/
.mvn/wrapper/maven-wrapper.jar
!.mvn/wrapper/maven-wrapper.properties
.idea
*.md
*.bat
*.ps1
```

---

## 🔄 Proceso de Build en Render

Con Docker, Render hará:

1. **Detectar Dockerfile** ✅
2. **Build de la imagen:**
   - Etapa 1: Compilar con Maven (JDK 17)
   - Etapa 2: Crear imagen final (JRE 17 Alpine)
3. **Crear PostgreSQL database** ✅
4. **Inyectar DATABASE_URL** ✅
5. **Iniciar contenedor** ✅

**Tiempo estimado:** 10-15 minutos (primera vez)

---

## ⚙️ Ventajas del Approach con Docker

### ✅ Más confiable
- Mismo entorno en local y producción
- No depende de configuraciones específicas de Render

### ✅ Optimizado
- Build multi-stage (imagen final más pequeña)
- Solo copia lo necesario (.dockerignore)
- Usa Alpine Linux (imagen ligera)

### ✅ Portable
- Funciona en cualquier plataforma que soporte Docker
- No solo Render (también Railway, Fly.io, AWS, etc.)

---

## 🧪 Probar Localmente con Docker (Opcional)

Si tienes Docker instalado, puedes probar antes de desplegar:

```bash
# Build de la imagen
docker build -t book-api .

# Ejecutar (sin database)
docker run -p 8080:8080 -e SPRING_PROFILES_ACTIVE=default book-api

# Probar
curl http://localhost:8080/api/books/health
```

---

## ⚠️ Notas Importantes

### Plan Free de Render con Docker
- ✅ 750 horas/mes gratis
- ⚠️ Build más lento que native (pero más confiable)
- ⚠️ Primera build: 10-15 min
- ✅ Builds posteriores: 5-8 min (usa caché)

### Variables de Entorno
- `PORT` - Asignado automáticamente por Render
- `DATABASE_URL` - Inyectado desde PostgreSQL
- `SPRING_PROFILES_ACTIVE=prod` - Hardcoded en Dockerfile

---

## 📝 Resumen

### ❌ Antes (NO funciona)
```yaml
runtime: java  # ❌ No válido en Render
```

### ✅ Ahora (Funciona)
```yaml
env: docker  # ✅ Usa Dockerfile
```

---

## 🚀 Próximos Pasos

1. ✅ **Hacer push** de los nuevos archivos
2. ✅ **Aplicar Blueprint** en Render
3. ✅ **Esperar 10-15 min** al build
4. ✅ **Probar tu API** en la URL de Render

---

## 📞 Si Hay Problemas

### Error: "Cannot find Dockerfile"
**Solución:** Asegúrate de hacer push:
```bash
git add Dockerfile
git commit -m "Add Dockerfile"
git push
```

### Error: "Build failed"
**Solución:** Revisa los logs en Render. Probablemente:
- Problema con Maven dependencies
- Problema con permisos de mvnw

### La app no inicia
**Solución:** Verifica en los logs que:
- DATABASE_URL está configurado
- Puerto PORT está siendo usado
- Profile prod está activo

---

**¡Ahora debería funcionar!** 🎉

**Siguiente paso:** Haz push y vuelve a intentar el Blueprint.

