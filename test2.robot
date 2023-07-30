*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Test Greeting Message with Edge
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys, selenium.webdriver

    # Set headless mode
    ${options.add_argument}=    --headless

    # Set the MSEdgeDriver executable path
    ${options.binary_location}=    C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe

    # Ouvrir le navigateur Microsoft Edge avec le pilote spécifié
    Open Browser    file:///C:/Users/hp/Desktop/pipline/MainClass.html    edge    options=${options}

    # Other test steps ...

    # Fermer le navigateur
    Close Browser
