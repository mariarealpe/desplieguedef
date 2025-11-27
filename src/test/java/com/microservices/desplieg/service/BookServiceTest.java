package com.microservices.desplieg.service;

import com.microservices.desplieg.dto.BookRequest;
import com.microservices.desplieg.dto.BookResponse;
import com.microservices.desplieg.model.Book;
import com.microservices.desplieg.repository.BookRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class BookServiceTest {

    @Mock
    private BookRepository bookRepository;

    @InjectMocks
    private BookService bookService;

    private Book book1;
    private Book book2;
    private BookRequest bookRequest;

    @BeforeEach
    void setUp() {
        book1 = new Book();
        book1.setId(1L);
        book1.setTitle("Clean Code");
        book1.setAuthor("Robert C. Martin");
        book1.setIsbn("978-0132350884");
        book1.setPrice(45.99);
        book1.setDescription("A Handbook of Agile Software Craftsmanship");
        book1.setCreatedAt(LocalDateTime.now());
        book1.setUpdatedAt(LocalDateTime.now());

        book2 = new Book();
        book2.setId(2L);
        book2.setTitle("Design Patterns");
        book2.setAuthor("Gang of Four");
        book2.setIsbn("978-0201633610");
        book2.setPrice(54.99);
        book2.setDescription("Elements of Reusable Object-Oriented Software");
        book2.setCreatedAt(LocalDateTime.now());
        book2.setUpdatedAt(LocalDateTime.now());

        bookRequest = new BookRequest();
        bookRequest.setTitle("Clean Code");
        bookRequest.setAuthor("Robert C. Martin");
        bookRequest.setIsbn("978-0132350884");
        bookRequest.setPrice(45.99);
        bookRequest.setDescription("A Handbook of Agile Software Craftsmanship");
    }

    @Test
    void getAllBooks_ShouldReturnListOfBooks() {
        // Arrange
        when(bookRepository.findAll()).thenReturn(Arrays.asList(book1, book2));

        // Act
        List<BookResponse> result = bookService.getAllBooks();

        // Assert
        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("Clean Code", result.get(0).getTitle());
        assertEquals("Design Patterns", result.get(1).getTitle());
        verify(bookRepository, times(1)).findAll();
    }

    @Test
    void getBookById_WhenBookExists_ShouldReturnBook() {
        // Arrange
        when(bookRepository.findById(1L)).thenReturn(Optional.of(book1));

        // Act
        BookResponse result = bookService.getBookById(1L);

        // Assert
        assertNotNull(result);
        assertEquals(1L, result.getId());
        assertEquals("Clean Code", result.getTitle());
        verify(bookRepository, times(1)).findById(1L);
    }

    @Test
    void getBookById_WhenBookDoesNotExist_ShouldThrowException() {
        // Arrange
        when(bookRepository.findById(999L)).thenReturn(Optional.empty());

        // Act & Assert
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            bookService.getBookById(999L);
        });
        
        assertTrue(exception.getMessage().contains("Libro no encontrado"));
        verify(bookRepository, times(1)).findById(999L);
    }

    @Test
    void getBookByIsbn_WhenBookExists_ShouldReturnBook() {
        // Arrange
        when(bookRepository.findByIsbn("978-0132350884")).thenReturn(Optional.of(book1));

        // Act
        BookResponse result = bookService.getBookByIsbn("978-0132350884");

        // Assert
        assertNotNull(result);
        assertEquals("978-0132350884", result.getIsbn());
        assertEquals("Clean Code", result.getTitle());
        verify(bookRepository, times(1)).findByIsbn("978-0132350884");
    }

    @Test
    void createBook_WhenIsbnDoesNotExist_ShouldCreateBook() {
        // Arrange
        when(bookRepository.existsByIsbn(bookRequest.getIsbn())).thenReturn(false);
        when(bookRepository.save(any(Book.class))).thenReturn(book1);

        // Act
        BookResponse result = bookService.createBook(bookRequest);

        // Assert
        assertNotNull(result);
        assertEquals("Clean Code", result.getTitle());
        assertEquals("Robert C. Martin", result.getAuthor());
        verify(bookRepository, times(1)).existsByIsbn(bookRequest.getIsbn());
        verify(bookRepository, times(1)).save(any(Book.class));
    }

    @Test
    void createBook_WhenIsbnAlreadyExists_ShouldThrowException() {
        // Arrange
        when(bookRepository.existsByIsbn(bookRequest.getIsbn())).thenReturn(true);

        // Act & Assert
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            bookService.createBook(bookRequest);
        });
        
        assertTrue(exception.getMessage().contains("Ya existe un libro con el ISBN"));
        verify(bookRepository, times(1)).existsByIsbn(bookRequest.getIsbn());
        verify(bookRepository, never()).save(any(Book.class));
    }

    @Test
    void updateBook_WhenBookExists_ShouldUpdateBook() {
        // Arrange
        when(bookRepository.findById(1L)).thenReturn(Optional.of(book1));
        when(bookRepository.save(any(Book.class))).thenReturn(book1);

        BookRequest updateRequest = new BookRequest();
        updateRequest.setTitle("Clean Code Updated");
        updateRequest.setAuthor("Robert C. Martin");
        updateRequest.setIsbn("978-0132350884");
        updateRequest.setPrice(49.99);
        updateRequest.setDescription("Updated description");

        // Act
        BookResponse result = bookService.updateBook(1L, updateRequest);

        // Assert
        assertNotNull(result);
        verify(bookRepository, times(1)).findById(1L);
        verify(bookRepository, times(1)).save(any(Book.class));
    }

    @Test
    void updateBook_WhenBookDoesNotExist_ShouldThrowException() {
        // Arrange
        when(bookRepository.findById(999L)).thenReturn(Optional.empty());

        // Act & Assert
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            bookService.updateBook(999L, bookRequest);
        });
        
        assertTrue(exception.getMessage().contains("Libro no encontrado"));
        verify(bookRepository, times(1)).findById(999L);
        verify(bookRepository, never()).save(any(Book.class));
    }

    @Test
    void deleteBook_WhenBookExists_ShouldDeleteBook() {
        // Arrange
        when(bookRepository.existsById(1L)).thenReturn(true);
        doNothing().when(bookRepository).deleteById(1L);

        // Act
        bookService.deleteBook(1L);

        // Assert
        verify(bookRepository, times(1)).existsById(1L);
        verify(bookRepository, times(1)).deleteById(1L);
    }

    @Test
    void deleteBook_WhenBookDoesNotExist_ShouldThrowException() {
        // Arrange
        when(bookRepository.existsById(999L)).thenReturn(false);

        // Act & Assert
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            bookService.deleteBook(999L);
        });
        
        assertTrue(exception.getMessage().contains("Libro no encontrado"));
        verify(bookRepository, times(1)).existsById(999L);
        verify(bookRepository, never()).deleteById(anyLong());
    }

    @Test
    void getBooksByAuthor_ShouldReturnBooksMatchingAuthor() {
        // Arrange
        when(bookRepository.findByAuthorContainingIgnoreCase("Martin")).thenReturn(Arrays.asList(book1));

        // Act
        List<BookResponse> result = bookService.getBooksByAuthor("Martin");

        // Assert
        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("Robert C. Martin", result.get(0).getAuthor());
        verify(bookRepository, times(1)).findByAuthorContainingIgnoreCase("Martin");
    }

    @Test
    void getBooksByTitle_ShouldReturnBooksMatchingTitle() {
        // Arrange
        when(bookRepository.findByTitleContainingIgnoreCase("Clean")).thenReturn(Arrays.asList(book1));

        // Act
        List<BookResponse> result = bookService.getBooksByTitle("Clean");

        // Assert
        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("Clean Code", result.get(0).getTitle());
        verify(bookRepository, times(1)).findByTitleContainingIgnoreCase("Clean");
    }
}

