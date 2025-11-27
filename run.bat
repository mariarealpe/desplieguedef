@echo off
pause

java -jar target\desplieg-0.0.1-SNAPSHOT.jar

echo.
echo Presiona Ctrl+C para detener el servidor
echo La aplicación estará disponible en: http://localhost:8080
echo [3/3] Iniciando la aplicación...
REM Ejecutar la aplicación

echo.
echo [2/3] Compilación exitosa
echo.

)
    exit /b %errorlevel%
    pause
    echo Error al compilar el proyecto
if %errorlevel% neq 0 (
call mvnw.cmd clean package -DskipTests
echo [1/3] Compilando el proyecto...
REM Compilar el proyecto

echo.
echo ========================================
echo Book API - Spring Boot
echo ========================================

REM Script para compilar y ejecutar la aplicación Book API

