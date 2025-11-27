@echo off
REM Script para compilar y descargar dependencias

echo ========================================
echo  Compilando y Descargando Dependencias
echo ========================================
echo.

echo Descargando dependencias de Maven...
call mvnw.cmd dependency:resolve

echo.
echo Compilando el proyecto...
call mvnw.cmd clean compile

echo.
echo ========================================
echo  Proceso completado
echo ========================================
pause

