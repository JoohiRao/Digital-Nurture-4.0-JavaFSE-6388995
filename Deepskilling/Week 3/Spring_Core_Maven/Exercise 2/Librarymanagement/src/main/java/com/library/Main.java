package com.library;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.library.service.BookService;

public class Main {
    public static void main(String[] args) {
        // Load Spring configuration
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        // Get BookService from Spring Container
        BookService service = context.getBean("bookService", BookService.class);

        // Test if dependency works
        service.addBook("Spring Guide");
    }
}
