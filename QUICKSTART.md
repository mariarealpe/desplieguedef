# 🚀 Inicio Rápido - Book API

## ⚡ Para Impacientes

### Windows:
```bash
# 1. Ejecutar la aplicación
run.bat

# 2. En otro terminal, probar la API
test-api.ps1
```

### Mac/Linux:
```bash
# 1. Ejecutar la aplicación
./mvnw spring-boot:run

# 2. En otro terminal, probar la API
curl http://localhost:8080/api/books/health
```

---

## 🎯 3 Pasos para Empezar

### 1️⃣ Verificar Prerequisitos
```bash
# Verificar Java
java -version
# Debe mostrar Java 17 o superior
```

### 2️⃣ Ejecutar la Aplicación
```bash
# Opción A: Doble clic en run.bat (Windows)
# Opción B: Comando
./mvnw spring-boot:run
```

### 3️⃣ Probar que Funciona
Abre tu navegador en: http://localhost:8080/api/books/health

Deberías ver:
```json
{
  "status": "UP",
  "service": "Book API"
}
```

---

## 📱 Primeras Pruebas

### Ver Todos los Libros
```bash
# Navegador
http://localhost:8080/api/books

# PowerShell
Invoke-RestMethod http://localhost:8080/api/books

# curl
curl http://localhost:8080/api/books
```

### Crear un Libro
```powershell
# PowerShell
$body = @{
    title = "Mi Libro"
    author = "Tu Nombre"
    isbn = "978-1234567890"
    price = 29.99
    description = "Un libro de prueba"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8080/api/books" `
    -Method Post `
    -Body $body `
    -ContentType "application/json"
```

---

## 🔥 Accesos Directos

| Recurso | URL |
|---------|-----|
| 🏥 Health Check | http://localhost:8080/api/books/health |
| 📚 Todos los Libros | http://localhost:8080/api/books |
| 🗄️ Consola H2 | http://localhost:8080/h2-console |

**Credenciales H2:**
- URL: `jdbc:h2:mem:bookdb`
- Usuario: `sa`
- Password: (vacío)

---

## 🧪 Ejecutar Pruebas

```bash
# Windows
test.bat

# Mac/Linux
./mvnw test
```

---

## 📖 Documentación Completa

- **README.md** - Documentación principal
- **API_TESTING_GUIDE.md** - Guía de pruebas completa
- **DEPLOYMENT_GUIDE.md** - Cómo desplegar en Render
- **PROJECT_SUMMARY.md** - Resumen del proyecto

---

## ❓ Solución Rápida de Problemas

### "JAVA_HOME no está definido"
```bash
# Windows: Instalar JDK 17
# Descargar de: https://adoptium.net/

# Verificar instalación
java -version
```

### "Puerto 8080 ya en uso"
```bash
# Detener proceso en puerto 8080
# Windows PowerShell:
Get-Process -Id (Get-NetTCPConnection -LocalPort 8080).OwningProcess | Stop-Process

# O cambiar el puerto en application.properties:
server.port=8081
```

### "No puedo conectar a H2"
- Asegúrate de que la aplicación está corriendo
- Usa la URL exacta: `jdbc:h2:mem:bookdb`
- Usuario: `sa`, Password: (vacío)

---

## 🎓 Siguiente Paso

Una vez que la aplicación funcione localmente, sigue la guía de despliegue:
👉 **DEPLOYMENT_GUIDE.md**

---

**¿Necesitas ayuda?** Lee la documentación completa en README.md

