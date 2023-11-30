*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    BuiltIn

*** Variables ***
${home_URL}    https://www.tp.edu.sg/home.html


${cca_CARD}    xpath=/html/body/div[3]/div[1]/div/div[4]/div/div[1]/div/div/div/div/div/div/div/div[3]
${cca_BTN}    xpath=/html/body/div[3]/div[1]/div/div[4]/div/div[1]/div/div/div/div/div/div/div/div[3]/div/div[2]/div/div/a

#CCA Count
${cca_TILE}    xpath=/html/body/div[3]/div[2]/div/div[2]/div/div/div/div/div[3]/div
${ccaDetail_BTN}    class:btn tp--button

@{cca_CAT}    Performing Arts CCAs    Sports CCAs    P10 Clubs & Interest Groups
*** Keywords ***
Open TP Home Page
    Open Browser    ${home_URL}    chrome
    Maximize Browser Window
    Title Should Be   Home | Temasek Polytechnic
    Location Should Be    ${home_URL}
    Click Element    class:cmp-t-and-c-cookie-close

Open Student Page
    Click Link    Students   
    Title Should Be    Students | Temasek Polytechnic
    Location Should Be   https://www.tp.edu.sg/landing/students.html

Close CCA Details    
    Click Button    xpath://button[@class='close' and @data-dismiss='modal' and @aria-label='Close']
    Wait Until Element Is Not Visible    xpath://button[@class='close' and @data-dismiss='modal' and @aria-label='Close']

*** Test Cases ***
CCA Details Are Accessible
    [Documentation]    Test CCAs details are displayed correctly and functioning 
    Open TP Home Page
    Open Student Page
    Scroll Element Into View    ${cca_CARD}
    #Store CCA Button Link
    ${cca_link}    Get Element Attribute    ${cca_BTN}    href
    Click Element    ${cca_BTN}

    #To Our CCA page
    Title Should Be    Our CCAs | Temasek Polytechnic
    Location Should Be    ${cca_link}

    #Performing Arts CCAs
    Scroll Element In To View    xpath=//li/a[text()='Performing Arts CCAs']
    Click Element    xpath=//li/a[text()='Performing Arts CCAs']
    #Band CCA
    Click Link    xpath=//a[contains(text(), 'Band')]
    #Close CCA Details
    Click Button    xpath://button[@type='button' and @class='close' and @data-dismiss='modal' and @aria-label='Close']
    Wait Until Element Is Not Visible    xpath://button[@type='button' and @class='close' and @data-dismiss='modal' and @aria-label='Close']
    #Check Section Name
    FOR    ${cat}    IN    @{cca_CAT}
        Scroll Element In To View    id=overview
        Click Element    xpath=//a[contains(text(), '${cat}')]
    END
    [Teardown]    Close Browser


    

