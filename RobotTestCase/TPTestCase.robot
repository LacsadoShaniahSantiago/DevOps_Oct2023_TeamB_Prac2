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
Visit Fees and Financial
    Open TP Home Page
    #Navigate to Admission and Finance
    Mouse Over    xpath=/html/body/div[2]/div[2]/div/div[1]/ul/li[2]/div[1]

    # Fees and Financial
    Click Element    xpath=/html/body/div[2]/div[2]/div/div[1]/ul/li[2]/div[2]/div/div[3]/a[1]
    Sleep    2s

    # Verify Website
    Title Should be    Fees & Financial Matters | Temasek Polytechnic
    Location Should be    https://www.tp.edu.sg/admissions-and-finance/fees-financial-matters.html

    Click Element    class:cmp-t-and-c-cookie-close

    # Click the all the dropdown buttons
    ${elements}=    Get WebElements    css:button.cmp-accordion__button
    FOR    ${element}    IN    @{elements}
        Click Element    ${element}
    END

    # Scroll backl to top
    Click Element    class:tp--back-to-top
    Sleep    2s

    Close Browser
