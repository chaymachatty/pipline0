package com.example;
public class MainClass {
    public static String getGreeting() {
        return "Hello,World!";
    }

    public static void main(String[] args) {
        while (true) {
            System.out.println(getGreeting());
            try {
                Thread.sleep(5000); // Print every 5 seconds
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

