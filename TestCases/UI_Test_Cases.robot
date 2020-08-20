*** Settings ***
Library  SeleniumLibrary
Resource  ../Resources/resources.robot
Test Setup  Open browser and maximize
Test Teardown   Close

*** Variables ***
${url}      http://127.0.0.1:5000/
${browser}      chrome


*** Test Cases ***
TC001_New_User_registration
    [Documentation]      This test case is to verify that we are able to register a new user
    [Tags]  Valid data verification
    ${NEWUSER_Username}=     Get Current Date
    &{new_user}=    create dictionary   Username=Auto${NEWUSER_Username}   Password=Test@12    FirstName=Testname  LastName=last   PhoneNumber=456723456
    set global variable  &{new_user}
    log to console  ${new_user.Username}
    Registration    True    &{new_user}


TC002_Login_and_Verify_user_info_after_successful_registration_for_new_user
    [Documentation]   This test case is to verify that we are able to login with the user already registered
    [Tags]  Valid data verification
    Login    ${new_user.Username}    ${new_user.Password}
    Verify_User_Information     &{new_user}
    Logout


TC003_Verify_Already_Registered_user
    [Documentation]  This test case is to verify that user is not able to register again if it is already registered
    [Tags]  Invalid data verification
    Registration    False    &{new_user}


TC004_Invalid_Login
    [Documentation]  This test case is to verify that successful login is not performed on entering either wrong username or wrong password
    [Tags]  Invalid data verification
    Login_with_Invalid_Credentials    ${new_user.Username}    wrongpassword
    Login_with_Invalid_Credentials    wrongusername           ${new_user.Password}
    Login_with_Invalid_Credentials    wrongusername           wrongpassword


*** Keywords ***
Login_with_Invalid_Credentials
    [Arguments]     ${User_name}    ${Password}
    click element   xpath://a[@href='/login']
    input text      xpath://input[@id='username']   ${User_name}
    input text      xpath://input[@id='password']   ${Password}
    click button    xpath://input[@value='Log In']
    page should contain  You provided incorrect login details






