# Fix de Despliegue en Render

## Problema Identificado

El error principal era:
```
Driver org.h2.Driver claims to not accept jdbcUrl, jdbc:postgresql://...
```

Esto ocurría porque Spring Boot estaba intentando usar el driver H2 (base de datos en memoria para desarrollo) para conectarse a PostgreSQL en producción.

## Cambios Realizados

### 1. **application-prod.properties**
Se actualizó para:
- Forzar el uso del driver PostgreSQL
- Deshabilitar H2 console en producción
- Deshabilitar la inicialización de data.sql en producción
- Configurar el dialecto de PostgreSQL

### 2. **DataSourceConfig.java**
Se mejoró para:
- Parsear correctamente la URL de DATABASE_URL de Render
- Extraer username y password de la URI
- Construir correctamente la URL JDBC de PostgreSQL
- Mejor manejo de errores

### 3. **pom.xml**
Se agregó:
- Configuración explícita de codificación UTF-8 para maven-resources-plugin
- Esto previene el error `MalformedInputException: Input length = 1`

### 4. **application.properties**
Se limpió y aseguró que:
- Esté correctamente codificado en UTF-8
- No tenga caracteres especiales que puedan causar problemas

## Cómo Desplegar en Render

### Paso 1: Hacer Commit de los Cambios

```bash
git add .
git commit -m "Fix PostgreSQL connection for Render deployment"
git push origin master
```

### Paso 2: Render Detectará los Cambios Automáticamente

Como ya tienes el Blueprint configurado, Render automáticamente:
1. Detectará el push a tu repositorio
2. Iniciará un nuevo deploy
3. Ejecutará el build usando el Dockerfile
4. Iniciará el servicio con las nuevas configuraciones

### Paso 3: Verificar el Despliegue

1. Ve a tu dashboard de Render
2. Observa los logs del deploy
3. Espera a que el status sea "Live"
4. Prueba la API en la URL proporcionada por Render

## Estructura de la Base de Datos

La aplicación creará automáticamente la tabla `books` con la siguiente estructura:

```sql
CREATE TABLE books (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(255) NOT NULL UNIQUE,
    price DOUBLE PRECISION NOT NULL,
    description VARCHAR(1000),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);
```

## Variables de Entorno en Render

Render proporciona automáticamente:
- `DATABASE_URL`: URL de conexión a PostgreSQL (formato: postgresql://user:pass@host:port/db)
- `PORT`: Puerto donde la aplicación debe escuchar (normalmente 10000)

La configuración `DataSourceConfig.java` parsea `DATABASE_URL` automáticamente.

## Pruebas Locales vs Producción

### Desarrollo Local (Perfil por defecto)
```bash
./mvnw spring-boot:run
```
- Usa H2 en memoria
- Puerto: 8080
- Datos de prueba se cargan desde data.sql
- H2 Console disponible en: http://localhost:8080/h2-console

### Producción en Render (Perfil prod)
```bash
java -Dspring.profiles.active=prod -jar app.jar
```
- Usa PostgreSQL
- Puerto: $PORT (variable de entorno de Render)
- data.sql NO se ejecuta
- Hibernate actualiza el schema automáticamente (ddl-auto=update)

## Troubleshooting

### Si el Deploy Falla

1. **Revisar los logs en Render:**
   - Ve a tu servicio > Logs
   - Busca errores específicos

2. **Verificar variables de entorno:**
   - Asegúrate de que DATABASE_URL esté configurada
   - Render la configura automáticamente si tienes la base de datos vinculada

3. **Problema de codificación:**
   - Si ves errores de MalformedInputException, verifica que todos los archivos .properties estén en UTF-8

4. **Problema de conexión a DB:**
   - Verifica que la base de datos esté en el mismo proyecto de Render
   - Asegúrate de que esté en estado "Available"

## Comandos Útiles

### Ver logs de la aplicación en Render:
```bash
# En el dashboard de Render, ve a tu servicio > Logs
```

### Probar la API localmente antes de desplegar:
```bash
# Compilar
./mvnw clean package -DskipTests

# Ejecutar
java -jar target/desplieg-0.0.1-SNAPSHOT.jar
```

### Probar con perfil de producción localmente (necesitas PostgreSQL):
```bash
export DATABASE_URL="postgresql://user:pass@localhost:5432/bookdb"
java -Dspring.profiles.active=prod -jar target/desplieg-0.0.1-SNAPSHOT.jar
```

## Próximos Pasos

Una vez desplegado exitosamente, puedes:
1. Probar los endpoints con Postman usando la URL de Render
2. Agregar más libros usando POST /api/books
3. Implementar pruebas unitarias
4. Agregar más funcionalidades CRUD

## URLs de Referencia

- **Documentación de Render**: https://render.com/docs
- **Spring Boot Profiles**: https://docs.spring.io/spring-boot/docs/current/reference/html/features.html#features.profiles
- **PostgreSQL en Render**: https://render.com/docs/databases

