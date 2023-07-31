*** Settings ***
Library    Process

*** Test Cases ***
Test Greeting
    ${output}=    Run Process    java -cp target/classes  com.example.MainClass
    Should Be Equal    ${output}    Hello, World!




