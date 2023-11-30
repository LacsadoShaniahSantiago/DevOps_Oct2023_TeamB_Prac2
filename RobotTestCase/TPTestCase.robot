*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    Dialogs
Library    Collections

*** Variables ***
${home_URL}    https://www.tp.edu.sg/home.html
${pfp_URL}    https://www.tp.edu.sg/schools-and-courses/students/schools/cfs/polytechnic-foundation-programme-pfp.html
${pfp_brochure_URL}    https://www.tp.edu.sg/content/dam/tp-web/files/schools-n-courses/for-prospective-students/centre-for-foundation-programme/polytechnic-foundation-programme/PFP%20booklet%202023.pdf
${courses}    Common ICT Programme 

*** Keywords ***
Open TP Home Page
    Open Browser    ${home_URL}    chrome
    Maximize Browser Window
    Title Should Be   Home | Temasek Polytechnic
    Location Should Be    ${home_URL}
    Click Element    class:cmp-t-and-c-cookie-close

### Luke Teran Murthi
Open TP PFP Page
    [Documentation]    To navigate to the PFP page and verify the title
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[2]/div/div[1]/ul/li[1]/div[1]
    Mouse Over    xpath=/html/body/div[2]/div[2]/div/div[1]/ul/li[1]/div[1]
    Wait Until Element Is Visible    xpath=/html/body/div[2]/div[2]/div/div[1]/ul/li[1]/div[2]/div/div[1]/a[3]
    Mouse Over    xpath=/html/body/div[2]/div[2]/div/div[1]/ul/li[1]/div[2]/div/div[1]/a[3]
    Click Element    xpath=/html/body/div[2]/div[2]/div/div[1]/ul/li[1]/div[2]/div/div[1]/a[3]
    Title Should Be    Polytechnic Foundation Programme | Temasek Polytechnic
    Location Should Be    ${pfp_URL}

View TP PFP brochure
    [Documentation]    To view the PFP brochure, the website should bring to a new tab and verify the title
    Wait Until Element Is Visible    xpath=/html/body/div[3]/div[1]/div/div[3]/div/div/div[2]/div/div[3]/div/div/p[6]/a
    ###Click Element    xpath=/html/body/div[3]/div[1]/div/div[3]/div/div/div[2]/div/div[3]/div/div/p[6]/a
    Click Link    View the brochure
    Sleep    3
    Switch Window    locator=NEW
    Location Should Be    ${pfp_brochure_URL}
    ###Pause Execution
    Close Window

Search CommonICT
    [Documentation]  This will search for Common ICT programme into the search bar in the TP Home 
    Input Text    css:input[placeholder="What can we help you find?"]    Common ICT
    Press Keys    None    ENTER
    Sleep    3


*** Test Cases ***
### Luke Teran Murthi
Test for PFP brochure
    [Documentation]    This test case is for PFP Polytechnic Foundation Programme
    Open TP Home Page
    Open TP PFP Page
    View TP PFP brochure
    
    Close Browser

Test to search function
    [Documentation]    This test case is to test the search function of the TP Home 
    Open TP Home Page
    Search CommonICT
    Close Browser

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