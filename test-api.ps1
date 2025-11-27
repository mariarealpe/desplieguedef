# Script de prueba completo para Book API
# Ejecutar con: .\test-api.ps1

$baseUrl = "http://localhost:8080/api/books"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Probando Book API - Spring Boot" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. Health Check
Write-Host "[1/9] Health Check..." -ForegroundColor Yellow
try {
    $health = Invoke-RestMethod -Uri "$baseUrl/health" -Method Get
    Write-Host "  ✓ Servicio activo: $($health.service)" -ForegroundColor Green
    Write-Host "  ✓ Estado: $($health.status)" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
Start-Sleep -Seconds 1

# 2. Obtener todos los libros (debe haber 5 precargados)
Write-Host "`n[2/9] Obteniendo todos los libros..." -ForegroundColor Yellow
try {
    $allBooks = Invoke-RestMethod -Uri $baseUrl -Method Get
    Write-Host "  ✓ Total de libros encontrados: $($allBooks.Count)" -ForegroundColor Green
    foreach ($book in $allBooks | Select-Object -First 3) {
        Write-Host "    - $($book.title) por $($book.author)" -ForegroundColor Gray
    }
} catch {
    Write-Host "  ✗ Error: $($_.Exception.Message)" -ForegroundColor Red
}
Start-Sleep -Seconds 1

# 3. Crear un nuevo libro
Write-Host "`n[3/9] Creando nuevo libro..." -ForegroundColor Yellow
try {
    $newBook = @{
        title = "Effective Java"
        author = "Joshua Bloch"
        isbn = "978-0134685991"
        price = 52.99
        description = "Best Practices for the Java Platform"
    } | ConvertTo-Json

    $created = Invoke-RestMethod -Uri $baseUrl -Method Post -Body $newBook -ContentType "application/json"
    $newBookId = $created.id
    Write-Host "  ✓ Libro creado con ID: $newBookId" -ForegroundColor Green
    Write-Host "    Título: $($created.title)" -ForegroundColor Gray
    Write-Host "    Autor: $($created.author)" -ForegroundColor Gray
    Write-Host "    Precio: `$$($created.price)" -ForegroundColor Gray
} catch {
    Write-Host "  ✗ Error: $($_.Exception.Message)" -ForegroundColor Red
}
Start-Sleep -Seconds 1

# 4. Obtener libro por ID
Write-Host "`n[4/9] Obteniendo libro por ID ($newBookId)..." -ForegroundColor Yellow
try {
    $bookById = Invoke-RestMethod -Uri "$baseUrl/$newBookId" -Method Get
    Write-Host "  ✓ Libro encontrado: $($bookById.title)" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Error: $($_.Exception.Message)" -ForegroundColor Red
}
Start-Sleep -Seconds 1

# 5. Obtener libro por ISBN
Write-Host "`n[5/9] Obteniendo libro por ISBN..." -ForegroundColor Yellow
try {
    $bookByIsbn = Invoke-RestMethod -Uri "$baseUrl/isbn/978-0134685991" -Method Get
    Write-Host "  ✓ Libro encontrado: $($bookByIsbn.title)" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Error: $($_.Exception.Message)" -ForegroundColor Red
}
Start-Sleep -Seconds 1

# 6. Buscar por autor
Write-Host "`n[6/9] Buscando libros por autor 'Martin'..." -ForegroundColor Yellow
try {
    $byAuthor = Invoke-RestMethod -Uri "$baseUrl/search/author?author=Martin" -Method Get
    Write-Host "  ✓ Libros encontrados: $($byAuthor.Count)" -ForegroundColor Green
    foreach ($book in $byAuthor) {
        Write-Host "    - $($book.title) por $($book.author)" -ForegroundColor Gray
    }
} catch {
    Write-Host "  ✗ Error: $($_.Exception.Message)" -ForegroundColor Red
}
Start-Sleep -Seconds 1

# 7. Buscar por título
Write-Host "`n[7/9] Buscando libros por título 'Java'..." -ForegroundColor Yellow
try {
    $byTitle = Invoke-RestMethod -Uri "$baseUrl/search/title?title=Java" -Method Get
    Write-Host "  ✓ Libros encontrados: $($byTitle.Count)" -ForegroundColor Green
    foreach ($book in $byTitle) {
        Write-Host "    - $($book.title)" -ForegroundColor Gray
    }
} catch {
    Write-Host "  ✗ Error: $($_.Exception.Message)" -ForegroundColor Red
}
Start-Sleep -Seconds 1

# 8. Actualizar libro
Write-Host "`n[8/9] Actualizando libro ID $newBookId..." -ForegroundColor Yellow
try {
    $updateBook = @{
        title = "Effective Java - 3rd Edition"
        author = "Joshua Bloch"
        isbn = "978-0134685991"
        price = 55.99
        description = "Best Practices for the Java Platform - Updated Edition"
    } | ConvertTo-Json

    $updated = Invoke-RestMethod -Uri "$baseUrl/$newBookId" -Method Put -Body $updateBook -ContentType "application/json"
    Write-Host "  ✓ Libro actualizado: $($updated.title)" -ForegroundColor Green
    Write-Host "    Nuevo precio: `$$($updated.price)" -ForegroundColor Gray
} catch {
    Write-Host "  ✗ Error: $($_.Exception.Message)" -ForegroundColor Red
}
Start-Sleep -Seconds 1

# 9. Eliminar libro
Write-Host "`n[9/9] Eliminando libro ID $newBookId..." -ForegroundColor Yellow
try {
    $deleted = Invoke-RestMethod -Uri "$baseUrl/$newBookId" -Method Delete
    Write-Host "  ✓ $($deleted.message)" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Error: $($_.Exception.Message)" -ForegroundColor Red
}
Start-Sleep -Seconds 1

# 10. Verificar lista final
Write-Host "`n[Final] Verificando lista final de libros..." -ForegroundColor Yellow
try {
    $finalBooks = Invoke-RestMethod -Uri $baseUrl -Method Get
    Write-Host "  ✓ Total de libros: $($finalBooks.Count)" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  ✓ Pruebas completadas exitosamente" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

