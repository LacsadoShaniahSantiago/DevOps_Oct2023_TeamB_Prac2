*** Settings ***
Library    SeleniumLibrary
Library    XML

*** Variables ***
${home_URL}    https://www.tp.edu.sg/home.html

*** Keywords ***
Open TP Home Page
    Open Browser    ${home_URL}    chrome
    Maximize Browser Window
    Title Should Be   Home | Temasek Polytechnic
    Location Should Be    ${home_URL}

*** Test Cases ***
Industry Partner
    [Documentation]    Test Case for navigating digital business transformation industry partners
    Open TP Home Page
    Click Element    xpath = //*[@id="navbarSupportedContent"]/div/ul/li[6]/a
    Click Element    xpath = /html/body/div[3]/div[1]/div/div[8]/div/div/div/div/div[2]/div/div/div/a
    Click Element    xpath = /html/body/div[6]/div/div/div
    Click Element    xpath = /html/body/div[3]/div[3]/div/div[2]/div/div[2]/div/a
    Click Element    xpath = /html/body/div[3]/div[2]/div[1]/div/div[2]/a[3]/img
    Sleep    2s
    Click Element    xpath = /html/body/div[3]/div[2]/div[1]/div/div[2]/a[4]/img
    Sleep    2s
    Click Element    xpath = /html/body/div[3]/div[2]/div[1]/div/div[2]/a[1]/img
    Click Element    xpath = //*[@id="shareIconsFirst"]/div/div[6]/a
