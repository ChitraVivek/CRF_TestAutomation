*** Settings ***

Library  SeleniumLibrary
Resource  ../Resource/Resource.robot

*** Test Cases ***


App Main page
    [Documentation]  ChecK Main page
    [Tags]  MainPage
    Open Browser To Main Page
    Main Page Should Be Open
    [Teardown]    Close Browser

Check Registration page
    [Documentation]  Verify Registration page
    [Tags]  RegistrationPage
    Open Browser To Main Page
    Open Registration Page
    [Teardown]     Close Browser

New User Register
    [Documentation]  Register New User
    [Tags]  NewUserRegistrationPage
    Open Browser To Main Page
    Open Registration Page
    Register New User
    Open Login Page
    [Teardown]     Close Browser

Check Login page
    [Documentation]  Verify Login page
    [Tags]  LoginPage
    Open Browser To Main Page
    Open Login Page
    [Teardown]     Close Browser

Check Invalid login
   [Documentation]  Verify Invalid user login
   [Tags]  InvalidUserLogin
   Open Browser To Main Page
   Open login page
   Invalid Username
   Open Login Page
   [Teardown]  Close Browser

Check Invalid Password
    [Documentation]  Verify Invalid password
    [Tags]  Invalid Password
    Open Browser To Main Page
    Open Login Page
    Invalid Password
    [Teardown]  Close Browser

Check Valid user login
    [Documentation]  Verify Valid user login
    [Tags]  UserLogin
    Open Browser To Main Page
    Open Login Page
    Valid login
    Log Out
    Main Page Should Be Open
    [Teardown]     Close Browser

*** Keywords ***

Start Demoapp Server
    Server Start