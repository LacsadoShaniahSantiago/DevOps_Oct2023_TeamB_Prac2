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
Campus News
    [Documentation]    Test Case for navigating and filtering TP campus news
    Open TP Home Page
    Click Element    xpath = /html/body/div[2]/div[2]/div/div[1]/ul/li[5]/div[1]
    Click Element    xpath = /html/body/div[2]/div[2]/div/div[1]/ul/li[5]/div[2]/div/div[2]/a[3]
    Click Element    xpath = /html/body/div[6]/div/div/div
    Click Element    xpath = //*[@id="release-list-filter"]/div[2]/div/div[6]/div[1]/div/a

    # Loop through ict filters
    ${ict_checkbox}    Create List    //*[@id="new-filter-6"]/div/label[2]/span    //*[@id="new-filter-6"]/div/label[3]/span    //*[@id="new-filter-6"]/div/label[4]/span    //*[@id="new-filter-6"]/div/label[5]/span    //*[@id="new-filter-6"]/div/label[6]/span    //*[@id="new-filter-6"]/div/label[7]/span    //*[@id="new-filter-6"]/div/label[8]/span
    
    FOR    ${filter}    IN    @{ict_checkbox}
        Click Element    xpath=${filter}
    END

    Scroll Element Into View   xpath = //*[@id="search-content-release"]
    Click Element    xpath = //*[@id="search-content-release"]
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