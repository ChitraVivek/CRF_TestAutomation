*** Settings ***

Library     SeleniumLibrary


*** Variables ***

${SERVER}       localhost:8080
${APP URL}      http://127.0.0.1:8080/
${BROWSER}      Firefox


# New User registration
${New_Username}     xyz
${New_Password}     xyz123
${New_Firstname}    FirstN
${New_Familyname}   FamilyN
${New_Phone}        1234567890

# invalied User login info
${Invalid_Username}  lmno
${Invalid_Password}  ab12

*** Keywords ***

Open Browser To Main Page
    Open Browser    ${APP URL}    ${BROWSER}
    Title Should Be    index page - Demo App

Main Page Should Be Open
    Page Should Contain Link  Demo app
    Page Should Contain  index page
    Page Should Contain Link  Log In
    Page Should Contain Link  Register

Open Registration Page
     Click Link  Register
     Title Should Be      Register - Demo App
     Page Should Contain  Username
     Page Should Contain  Password
     Page Should Contain  First name
     Page Should Contain  Family Name
     Page Should Contain  Phone number

Register New User
     Input Text  id:username   ${New_Username}
     Input Text  id:password   ${New_Password}
     Input Text  id:firstname  ${New_Firstname}
     Input Text  id:lastname   ${New_Familyname}
     Input Text  id:phone      ${New_Phone}
     Click Button	Register
     Open Login Page
     Title Should Be    Log In - Demo App
     Page Should Contain  Username
     Page Should Contain  Password

Open Login Page
     Click Link           Log In
     Title Should Be      Log In - Demo App
     Page Should Contain  Username
     Page Should Contain  Password

Valid login
     Open Login Page
     Input Text                    id:username  ${New_Username}
     Input Password                id:password  ${New_Password}
     Click Button	               Log In
     Title Should Be               User Information - Demo App
     Page should Contain Element   id:username   ${New_Username}
     Page Should Contain Element   id:firstname  ${New_Firstname}
     Page Should Contain Element   id:lastname   ${New_Familyname}
     Page Should Contain Element   id:phone      ${New_Phone}

Invalid Password
     Open Login Page
     Input Text             id:username  ${New_Username}
     Input Password         id:password  ${Invalid_Password}
     Click Button	        Log In
     Page Should Contain    Login Failure

Invalid Username
     Open Login Page
     Input Text             id:username  ${Invalid_Username}
     Input Password         id:password  ${New_Password}
     Click Button	        Log In
     Page Should Contain    Login Failure


Log Out
     Click Link  Log Out

