*** Settings ***
Library  SeleniumLibrary
Library     Collections
Library     DateTime

*** Variables ***


*** Keywords ***
Open browser and maximize
    Open Browser     http://127.0.0.1:5000/       chrome
    maximize browser window
    #set selenium speed       1 sec


Close
    Close Browser


Registration
    [Arguments]     ${Expectation}      &{User}
    #page should contain  index page
    click element   xpath://a[@href='/register']
    page should contain     Register
    #${User_name}=    Get From Dictionary     ${User}     Username
    input text      xpath://input[@id='username']   ${User.Username}
    input text      xpath://input[@id='password']   ${User.Password}
    input text      xpath://input[@id='firstname']  ${User.FirstName}
    input text      xpath://input[@id='lastname']   ${User.LastName}
    input text      xpath://input[@id='phone']      ${User.PhoneNumber}
    click button    xpath://input[@value='Register']
    run keyword if  ${Expectation}==True
    ...     page should contain button      //input[@value='Log In']
    ...     ELSE
    ...    page should contain     User ${User.Username} is already registered.


Login
    [Arguments]     ${User_name}    ${Password}
    click element   xpath://a[@href='/login']
    input text      xpath://input[@id='username']   ${User_name}
    input text      xpath://input[@id='password']   ${Password}
    click button    xpath://input[@value='Log In']
    title should be  User Information - Demo App

Logout
    click element      //a[@href='/logout']
    title should be  index page - Demo App


Verify_User_Information
    [Arguments]  &{User}
    table cell should contain   xpath://table[@id='content']  2   2   ${User.Username}
    table cell should contain   xpath://table[@id='content']  3   2   ${User.FirstName}
    table cell should contain   xpath://table[@id='content']  4   2   ${User.LastName}
    table cell should contain   xpath://table[@id='content']  5   2   ${User.PhoneNumber}
