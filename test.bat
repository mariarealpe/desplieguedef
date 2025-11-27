@echo off
REM Script para ejecutar las pruebas unitarias

echo ========================================
echo Ejecutando Pruebas Unitarias
echo ========================================
echo.

call mvnw.cmd test

echo.
echo ========================================
echo Pruebas completadas
echo ========================================
pause

