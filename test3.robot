*** Settings ***
Library    Process
Library    String

*** Test Cases ***
Run Java Application Test
    ${jar_path}    Set Variable    C:/Users/hp/Desktop/piplinev0/target/devops-pipeline.jar
    ${java_file}    Set Variable    C:/Users/hp/Desktop/piplinev0/src/main/java/com/example/MainClass.java

    # Compile Java source file
    Run Process    javac    ${java_file}

    # Run the Java application and capture the output
    ${result}    Run Process    java    -cp    ${jar_path}    com.example.MainClass

    # Verify if the output is equal to "Hello, World!"
    ${output}    Set Variable    ${result.stdout.strip()}
    Should Be Equal As Strings    ${output}    Hello,World!

    # Print the captured output and expected output for debugging
    Log    Captured Output: ${output}
    Log    Expected Output: Hello,World!