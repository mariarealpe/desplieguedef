# ✅ CHECKLIST PARA DESPLEGAR EN RENDER

## 📋 PASO A PASO - DEPLOYMENT COMO BLUEPRINT

### ✅ PRE-REQUISITOS (Ya los tienes)
- ✅ Cuenta en GitHub
- ✅ Cuenta en Render (gratis)
- ✅ Proyecto funcionando localmente
- ✅ Archivo `render.yaml` configurado

---

## 🚀 PASOS PARA DESPLEGAR

### 1️⃣ SUBIR A GITHUB

#### Inicializar Git (si no lo has hecho)
```bash
cd C:\Users\maho4\IdeaProjects\desplieg
git init
git add .
git commit -m "Initial commit: Book API Spring Boot"
```

#### Crear repositorio en GitHub
1. Ve a: https://github.com/new
2. **Nombre del repositorio:** `book-api-spring-boot` (o el que prefieras)
3. **Descripción:** "API REST CRUD para gestión de libros con Spring Boot"
4. **Público** (para usar Render Free)
5. **NO marques:** README, .gitignore, license (ya los tienes)
6. Clic en **"Create repository"**

#### Conectar y subir
```bash
git remote add origin https://github.com/TU_USUARIO/book-api-spring-boot.git
git branch -M main
git push -u origin main
```

---

### 2️⃣ DESPLEGAR EN RENDER (Blueprint - AUTOMÁTICO)

#### A. Ir a Render Dashboard
1. Ve a: https://dashboard.render.com
2. Inicia sesión o crea cuenta (usa GitHub para facilitar)

#### B. Conectar Repositorio
1. Clic en **"New +"** (arriba derecha)
2. Selecciona **"Blueprint"**
3. Conecta tu cuenta de GitHub si no lo has hecho
4. Busca y selecciona: `book-api-spring-boot`
5. Clic en **"Connect"**

#### C. Aplicar Blueprint
1. Render detectará automáticamente el archivo `render.yaml`
2. Verás 2 recursos que se crearán:
   - ✅ **Web Service:** `desplieg-api`
   - ✅ **PostgreSQL Database:** `desplieg-db`
3. Clic en **"Apply"**

#### D. Esperar el Deployment
1. **Primera vez:** 5-10 minutos
2. Verás los logs en tiempo real
3. Render automáticamente:
   - ✅ Crea la base de datos PostgreSQL
   - ✅ Descarga las dependencias Maven
   - ✅ Compila el proyecto
   - ✅ Conecta la base de datos
   - ✅ Inicia la aplicación

#### E. Verificar que está Live
Cuando veas:
```
✓ Build successful
✓ Deploy live
```

¡Tu API está en línea! 🎉

---

### 3️⃣ OBTENER LA URL Y PROBAR

#### Obtener URL
1. En Render Dashboard, entra a **`desplieg-api`**
2. Arriba verás tu URL: `https://desplieg-api-XXXXX.onrender.com`
3. Copia esa URL

#### Probar la API
Reemplaza `TU_URL` con la URL de Render:

**Health Check:**
```
https://TU_URL.onrender.com/api/books/health
```

**Ver libros (estará vacía en producción):**
```
https://TU_URL.onrender.com/api/books
```

**Crear primer libro (usar Postman o curl):**
```bash
curl -X POST https://TU_URL.onrender.com/api/books \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Clean Code",
    "author": "Robert C. Martin",
    "isbn": "978-0132350884",
    "price": 45.99,
    "description": "A Handbook of Agile Software Craftsmanship"
  }'
```

---

## 🔍 TROUBLESHOOTING

### ❌ Build Failed
**Causa común:** Error en la compilación

**Solución:**
1. Revisa los logs en Render
2. Asegúrate que el proyecto compila localmente: `mvnw clean package`
3. Verifica que `render.yaml` esté en la raíz del repo

### ❌ Application Crashed
**Causa común:** Error al conectar con la base de datos

**Solución:**
1. Verifica que la base de datos `desplieg-db` esté en estado "Available"
2. Asegúrate que la variable `DATABASE_URL` esté conectada
3. Revisa los logs de la aplicación

### ⚠️ Primera petición muy lenta
**Esto es NORMAL en el plan Free:**
- La app se "duerme" después de 15 min de inactividad
- Primera petición tarda 30-60 segundos
- Peticiones siguientes son rápidas

---

## 📊 QUÉ ESPERAR

### ✅ Base de Datos
- **PostgreSQL Free:** 256 MB
- **Ubicación:** Misma región que tu servicio
- **Conexión:** Automática vía `DATABASE_URL`
- **Datos iniciales:** NO se cargan (data.sql solo en desarrollo)

### ✅ Web Service
- **Runtime:** Java 17
- **Build:** Maven
- **Puerto:** Asignado por Render ($PORT)
- **Profile:** prod (PostgreSQL)
- **Plan Free:** 750 horas/mes

### ✅ Auto-Deploy
- **Cada push a `main`:** Render re-despliega automáticamente
- **Tiempo de re-deploy:** 3-5 minutos
- **Rollback:** Disponible en el dashboard

---

## 🎯 RESUMEN

### ¿Qué hace el Blueprint?

El archivo `render.yaml` le dice a Render:

1. **Crear PostgreSQL Database**
   - Nombre: `desplieg-db`
   - Base de datos: `bookdb`
   - Plan: Free

2. **Crear Web Service**
   - Nombre: `desplieg-api`
   - Runtime: Java 17
   - Build: `mvnw clean package -DskipTests`
   - Start: `java -Dserver.port=$PORT -Dspring.profiles.active=prod -jar target/desplieg-0.0.1-SNAPSHOT.jar`
   - Plan: Free

3. **Conectar ambos automáticamente**
   - Variable `DATABASE_URL` inyectada automáticamente

### ¿Qué NO necesitas hacer?

- ❌ Configurar variables de entorno manualmente
- ❌ Crear la base de datos por separado
- ❌ Configurar conexiones
- ❌ Instalar Java o Maven
- ❌ Configurar el servidor

**TODO es automático con el Blueprint** ✨

---

## 📝 COMANDOS ÚTILES

### Ver logs en tiempo real
```bash
# Desde Render Dashboard
# Ir a tu servicio → Logs (pestaña)
```

### Re-desplegar manualmente
```bash
# En Render Dashboard
# Ir a tu servicio → Manual Deploy → Deploy latest commit
```

### Ver base de datos
```bash
# En Render Dashboard
# Ir a desplieg-db → Info
# Copiar "External Database URL" para conectar con un cliente SQL
```

---

## 🎉 ¡LISTO!

Una vez desplegado:

1. ✅ Tu API estará en: `https://desplieg-api-XXXXX.onrender.com`
2. ✅ Actualiza la variable `baseUrl` en Postman
3. ✅ Prueba todos los endpoints
4. ✅ Cada push a GitHub actualiza automáticamente

---

## 🔗 RECURSOS

- **Render Dashboard:** https://dashboard.render.com
- **Documentación Render:** https://render.com/docs
- **Blueprint Spec:** https://render.com/docs/blueprint-spec
- **Spring Boot en Render:** https://render.com/docs/deploy-spring-boot

---

**¿Algún problema? Revisa `DEPLOYMENT_GUIDE.md` para más detalles.**

**¡Éxito con tu deployment!** 🚀

