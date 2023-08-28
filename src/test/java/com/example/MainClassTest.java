package com.example;

import org.junit.Test;
import static org.junit.Assert.*;

public class MainClassTest {

    @Test
    public void testGetGreeting() {
        GreetingController controller = new GreetingController();
        String greeting = controller.getGreeting();
        assertEquals("Hello, World!", greeting);
    }
}
