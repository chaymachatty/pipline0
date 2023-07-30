*** Settings ***
Library    SeleniumLibrary  

*** Test Cases ***
Test Greeting Message with Edge
    # Ouvrir le navigateur Microsoft Edge avec le pilote spécifié
    Open Browser    file:///C:/Users/hp/Desktop/pipline/MainClass.html    edge    executable_path=C:\\Users\\hp\\Downloads\\edgedriver_win64\\msedgedriver.exe

    # Attendre 2 secondes pour permettre au site de se charger complètement
    Sleep    2s

    # Obtenir le texte de l'élément contenant le message de salutation
    ${greeting}    Get Text    xpath=//div[@id="Greetings"]/h1

    # Vérifier que le message de salutation est correct
    Should Be Equal    ${greeting}    Hello, World!

    # Fermer le navigateur
    Close Browser
