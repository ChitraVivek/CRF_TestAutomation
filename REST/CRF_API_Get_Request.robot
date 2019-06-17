*** Settings ***

Library         OperatingSystem
Library  		Collections
Library  		String
Library		    RequestsLibrary
Library         JSONLibrary

*** Variables ***

${JSON_SERVICE_URL}         http://127.0.0.1:8080/
${resp}


*** Test Cases ***

TC_01_Get_Request
    Create Session  Test_Get_Request  ${JSON_SERVICE_URL}
    Get Request  Test_Get_Request   api/auth/token

TC_02_Get_Request
    Create Session  Test_Get_User_Request  ${JSON_SERVICE_URL}
    Get Request  Test_Get_User_Request  api/users

TC_03_Get_JSON
    ${headers} =  Create Dictionary  Content-Type=application/json
    Set test Variable  ${HEADERS}  ${headers}
    Create Session  session  ${JSON_SERVICE_URL}  headers=${headers}
    Get JSON data    /api/users

*** Keywords ***

Get JSON data
      [Arguments]  ${uri}  ${header}=${HEADERS}
      [Documentation]  Reads the data as JSON object through REST API. The service URI is given as an argument.
      ...  Returns the response as a JSON object.
      ${resp}=  Get Request  session  ${uri}  headers=${HEADERS}
      log  ${resp.content}
      Should Be Equal As Strings  ${resp.status_code}  200
      ${actual}=  To Json  ${resp.content}
      Log  ${resp.content}
      [Return]  ${actual}

