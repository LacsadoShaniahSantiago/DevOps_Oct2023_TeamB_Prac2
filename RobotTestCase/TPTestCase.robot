*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    Dialogs
Library    Collections
Library    BuiltIn

*** Variables ***
${home_URL}    https://www.tp.edu.sg/home.html
${pfp_URL}    https://www.tp.edu.sg/schools-and-courses/students/schools/cfs/polytechnic-foundation-programme-pfp.html
${pfp_brochure_URL}    https://www.tp.edu.sg/content/dam/tp-web/files/schools-n-courses/for-prospective-students/centre-for-foundation-programme/polytechnic-foundation-programme/PFP%20booklet%202023.pdf
${courses}    Common ICT Programme 


${cca_CARD}    xpath=/html/body/div[3]/div[1]/div/div[4]/div/div[1]/div/div/div/div/div/div/div/div[3]
${cca_BTN}    xpath=/html/body/div[3]/div[1]/div/div[4]/div/div[1]/div/div/div/div/div/div/div/div[3]/div/div[2]/div/div/a

#CCA Count
${cca_TILE}    xpath=/html/body/div[3]/div[2]/div/div[2]/div/div/div/div/div[3]/div
${ccaDetail_BTN}    class:btn tp--button

@{cca_CAT}    Performing Arts CCAs    Sports CCAs    P10 Clubs & Interest Groups

@{skills_NAV}    Emerging Domains    Our Services    Course Types    News & Events    Other Resources
*** Keywords ***
### Common Keywords
Open TP Home Page
    Open Browser    ${home_URL}    chrome
    Maximize Browser Window
    Title Should Be   Home | Temasek Polytechnic
    Location Should Be    ${home_URL}
    Click Element    class:cmp-t-and-c-cookie-close

### Luke Teran Murthi - Keywords
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

### Lacsado Shaniah Santiago - Keywords
Open Student Page
    Click Link    Students   
    Title Should Be    Students | Temasek Polytechnic
    Location Should Be   https://www.tp.edu.sg/landing/students.html

Close CCA Details    
    Click Button    xpath://button[@class='close' and @data-dismiss='modal' and @aria-label='Close']
    Wait Until Element Is Not Visible    xpath://button[@class='close' and @data-dismiss='modal' and @aria-label='Close']

Open Adult Learners Page
    Click Link    Adult Learners
    Title Should Be    Adult Learners | Temasek Polytechnic
    Location Should Be    https://www.tp.edu.sg/landing/adult-learners.html

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

### Koay Yi Ting
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

### Ng Zi Yi
Campus News
    [Documentation]    Test Case for navigating and filtering TP campus news
    Open TP Home Page
    Click Element    xpath = /html/body/div[2]/div[2]/div/div[1]/ul/li[5]/div[1]
    Click Element    xpath = /html/body/div[2]/div[2]/div/div[1]/ul/li[5]/div[2]/div/div[2]/a[3]
    Click Element    xpath = //*[@id="release-list-filter"]/div[2]/div/div[6]/div[1]/div/a

    # Loop through ict filters
    ${ict_checkbox}    Create List    //*[@id="new-filter-6"]/div/label[2]/span    //*[@id="new-filter-6"]/div/label[3]/span    //*[@id="new-filter-6"]/div/label[4]/span    //*[@id="new-filter-6"]/div/label[5]/span    //*[@id="new-filter-6"]/div/label[6]/span    //*[@id="new-filter-6"]/div/label[7]/span    //*[@id="new-filter-6"]/div/label[8]/span
    
    FOR    ${filter}    IN    @{ict_checkbox}
        Click Element    xpath=${filter}
    END

    Scroll Element Into View   xpath = //*[@id="search-content-release"]
    Click Element    xpath = //*[@id="search-content-release"]
    Sleep    1s
    Input Text    xpath = //*[@id="search-content-release"]    game
    Press Keys    xpath = //*[@id="search-content-release"]    ENTER
    Sleep    2s
    
     # Wait for the element to be visible before clicking it
    Wait Until Element Is Visible    xpath = /html/body/div[3]/div[1]/div/div[3]/div/div[2]/div/div[3]/div[2]/div[2]/a    timeout=10s
    Click Element    xpath = /html/body/div[3]/div[1]/div/div[3]/div/div[2]/div/div[3]/div[2]/div[2]/a
    Switch Window    new
    Location Should Be    https://www.tp.edu.sg/about-tp/media-centre/campus-news/our-students-lee-wei-sheng-darren.html
    Title Should Be    Our Students - Lee Wei Sheng Darren | Temasek Polytechnic

    Sleep    5s
    Close Browser

Industry Partner
    [Documentation]    Test Case for navigating digital business transformation industry partners
    Open TP Home Page
    Click Element    xpath = //*[@id="navbarSupportedContent"]/div/ul/li[6]/a
    
    Scroll Element Into View    xpath = /html/body/div[3]/div[1]/div/div[7]
    
    ${focus_areas}    Create List    /html/body/div[3]/div[1]/div/div[7]/div/div/div[1]/div/div/div/a/div/div    /html/body/div[3]/div[1]/div/div[7]/div/div/div[2]/div/div/div/a    /html/body/div[3]/div[1]/div/div[7]/div/div/div[3]/div/div/div/a  /html/body/div[3]/div[1]/div/div[7]/div/div/div[4]/div/div/div/a    /html/body/div[3]/div[1]/div/div[8]/div/div/div/div/div[1]/div/div/div/a   /html/body/div[3]/div[1]/div/div[8]/div/div/div/div/div[2]/div/div/div/a    /html/body/div[3]/div[1]/div/div[8]/div/div/div/div/div[3]/div/div/div/a    /html/body/div[3]/div[1]/div/div[8]/div/div/div/div/div[4]/div/div/div/a
    FOR    ${area}    IN    @{focus_areas}
        Mouse Over    xpath=${area}
        Sleep    2s
    END

    Click Element    xpath = /html/body/div[3]/div[1]/div/div[8]/div/div/div/div/div[2]/div/div/div/a
    
    Click Element    xpath = /html/body/div[3]/div[3]/div/div[2]/div/div[2]/div/a
    Click Element    xpath = /html/body/div[3]/div[2]/div[1]/div/div[2]/a[3]/img
    Sleep    2s
    Click Element    xpath = /html/body/div[3]/div[2]/div[1]/div/div[2]/a[4]/img
    Sleep    2s
    Click Element    xpath = /html/body/div[3]/div[2]/div[1]/div/div[2]/a[1]/img
    Click Element    xpath = //*[@id="shareIconsFirst"]/div/div[6]/a
    Close Browser

### Lacsado Shaniah Santiago
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

TP Skills Updgrading and Mastery Navigations
    Open TP Home Page
    Open Adult Learners Page
    Scroll Element In To View    xpath=//img[@usemap='#image-map']
    FOR    ${nav}    IN    @{skills_NAV}
        Scroll Element In To View    xpath=//h3[contains(text(), 'Skills Upgrading and Mastery')]
        ${element}=    Get WebElement    xpath=//map[@name='image-map']
        Click Element    xpath=//area[@title='${nav}']
    END
    Close Browser
