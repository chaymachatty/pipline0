*** Settings ***
Library    SeleniumLibrary  

*** Test Cases ***
Test Greeting Message with Edge (Headless)
    # Define options for running in headless mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys

    # Add the headless argument to the options
    Call Method    ${options}    add_argument    --headless

    # Set the executable path for the Edge WebDriver
    ${executable_path}=    Set Variable    C:\\Users\\hp\\Downloads\\edgedriver_win64\\msedgedriver.exe

    # Ouvrir le navigateur Microsoft Edge avec le pilote spécifié en mode headless
    Open Browser    file:///C:/Users/hp/Desktop/pipline/MainClass.html    edge    options=${options}    executable_path=${executable_path}

    # Attendre 2 secondes pour permettre au site de se charger complètement
    Sleep    2s

    # Obtenir le texte de l'élément contenant le message de salutation
    ${greeting}    Get Text    xpath=//div[@id="Greetings"]/h1

    # Vérifier que le message de salutation est correct
    Should Be Equal    ${greeting}    Hello, World!

    # Fermer le navigateur
    Close Browser
