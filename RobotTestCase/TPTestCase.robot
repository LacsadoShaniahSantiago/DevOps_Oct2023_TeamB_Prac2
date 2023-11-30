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
    Click Element    class:cmp-t-and-c-cookie-close

*** Test Cases ***

# Koay Yi Ting
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

    # Click the all the dropdown buttons
    ${elements}=    Get WebElements    css:button.cmp-accordion__button
    FOR    ${element}    IN    @{elements}
        Click Element    ${element}
    END

    # Scroll backl to top
    Click Element    class:tp--back-to-top
    Sleep    2s

    Close Browser

Visit VR Campus Tour
    Open TP Home Page
    # Navigation Bar Life@TP
    Mouse Over    xpath=/html/body/div[2]/div[2]/div/div[1]/ul/li[3]/div[1]

    # VR Tour
    Click Element    xpath=/html/body/div[2]/div[2]/div/div[1]/ul/li[3]/div[2]/div/div[1]/a[2]

    # Verify Website
    Title Should be    Campus Virtual Tour | Temasek Polytechnic
    Location Should be    https://www.tp.edu.sg/vrtour/

    # Enter Page
    Click Element    id:landing_explore_button
    Sleep    2s

    # Play Iframe Youtube Video
    Select Frame    xpath=//iframe[@id='landingPage_introVid_video']
    Click Element    xpath=//button[@aria-label="Play"]
    Sleep    1s

    # Get out of iframe
    Unselect Frame
    Click Element    id:landingPage_introVid_skip_button
    Sleep    2s

    # Test one button
    Click Element    id:launchpad_mapPin

    # Loop through the elements
    @{map_elements}=     Get WebElements    xpath://*[@class='map_pin']
    FOR    ${element}    IN    @{map_elements}
        ${element_id}=    SeleniumLibrary.Get Element Attribute    ${element}    id
        Wait Until Element Is Enabled    id:${element_id}
        LOG        ${element_id}
        Click Element    id:${element_id}
    END

    Close Browser
