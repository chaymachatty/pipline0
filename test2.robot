*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Test Greeting Message with Edge in Headless Mode
    # Set Edge Options for Headless Mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless

    # Set the path to the msedgedriver executable
    Call Method    ${options}    add_argument    executable_path=C:\\Users\\hp\\Downloads\\edgedriver_win64\\msedgedriver.exe

    # Ouvrir le navigateur Microsoft Edge en mode headless avec le pilote spécifié
    Open Browser    file:///C:/Users/hp/Desktop/pipline/MainClass.html    edge    options=${options}

    # Attendre 2 secondes pour permettre au site de se charger complètement
    Sleep    2s

    # Obtenir le texte de l'élément contenant le message de salutation
    ${greeting}    Get Text    xpath=//div[@id="Greetings"]/h1

    # Vérifier que le message de salutation est correct
    Should Be Equal    ${greeting}    Hello, World!

    # Fermer le navigateur
    Close Browser
