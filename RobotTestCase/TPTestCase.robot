*** Settings ***
Library    SeleniumLibrary
Library    XML

*** Variables ***
${home_URL}    https://www.tp.edu.sg/home.html

@{skills_NAV}    Emerging Domains    Our Services    Course Types    News & Events    Other Resources
*** Keywords ***
Open TP Home Page
    Open Browser    ${home_URL}    chrome
    Maximize Browser Window
    Title Should Be   Home | Temasek Polytechnic
    Location Should Be    ${home_URL}
    Click Element    class:cmp-t-and-c-cookie-close

Open Adult Learners Page
    Click Link    Adult Learners
    Title Should Be    Adult Learners | Temasek Polytechnic
    Location Should Be    https://www.tp.edu.sg/landing/adult-learners.html

*** Test Cases ***
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

