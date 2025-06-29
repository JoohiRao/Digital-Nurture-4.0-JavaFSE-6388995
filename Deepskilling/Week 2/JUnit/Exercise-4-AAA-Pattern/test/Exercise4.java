package org.example;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

public class Exercise4 {

    private Calculator calc;

    @Before
    public void setUp() {
        calc = new Calculator();
        System.out.println("Setup done.");
    }

    @After
    public void tearDown() {
        System.out.println("Teardown done.");
    }

    @Test
    public void testAdd() {
        int result = calc.add(4, 6);
        assertEquals(10, result);
    }

    @Test
    public void testSubtract() {
        int result = calc.subtract(10, 3);
        assertEquals(7, result);
    }
}
