package com.example;

import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class MainClassTest {

    @Test
    public void testGetGreeting() {
        String expected = "Hello, World!";
        String actual = MainClass.getGreeting();
        assertEquals(expected, actual);
    }
}
