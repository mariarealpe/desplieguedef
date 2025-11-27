-- Datos iniciales para la tabla de libros
INSERT INTO books (title, author, isbn, price, description, created_at, updated_at) VALUES
('Clean Code', 'Robert C. Martin', '978-0132350884', 45.99, 'A Handbook of Agile Software Craftsmanship', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Design Patterns', 'Gang of Four', '978-0201633610', 54.99, 'Elements of Reusable Object-Oriented Software', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Refactoring', 'Martin Fowler', '978-0134757599', 47.99, 'Improving the Design of Existing Code', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('The Pragmatic Programmer', 'Andy Hunt & Dave Thomas', '978-0135957059', 42.99, 'Your Journey to Mastery', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Head First Java', 'Kathy Sierra & Bert Bates', '978-0596009205', 39.99, 'A Brain-Friendly Guide', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

