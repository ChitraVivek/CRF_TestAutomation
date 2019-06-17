*** Settings ***

Library         OperatingSystem
Library  		Collections
Library  		String
Library		    RequestsLibrary

*** Variables ***

${JSON_SERVICE_URL}         http://127.0.0.1:8080/
${REST_API_USER}            someuserName
${REST_API_PASS}            somePassword

*** Test Cases ***

Get test
    [Tags]  Request
    Initialize session
    Test get function

*** Keywords ***

Test get function
    set test variable   ${JSON_SERVICE_URL}
    ${get}=  Get JSON data  /api/auth/token
    log  ${get}
    Set Test Variable  ${RESP}  ${get}

Parse token
      [Arguments]  ${token}=${authorizationToken}
      log  ${token}
      ${stringToken}=  catenate  ${token}  1  #just to make it to string
      Should Be String  ${stringToken}
      ${fromLeft}=    Fetch from left      ${stringToken}         ', u'id':
      log  ${fromLeft}
      ${fromRight}=   Fetch from right     ${fromLeft}       	{u'token': u'
      log  ${fromRight}
      set test variable  ${parsedAuthorizationToken}  ${fromRight}

Initialize Session
      [Documentation]  Creates context for REST API calls.
      [Arguments]  ${apiUrl}=${JSON_SERVICE_URL}
      Get authorization token
      Parse token
      ${newHeaders} =  Create Dictionary  Authorization=Bearer ${parsedAuthorizationToken}
      Set test Variable  ${HEADERS}  ${newHeaders}
      Create Session  session  ${apiUrl}  headers=${HEADERS}
      log  ${HEADERS}

Get authorization token
      [Arguments]    ${apiUrl}=${JSON_SERVICE_URL}  ${token}
      ${headers} =  Create Dictionary  Content-Type=application/json
      Set test Variable  ${HEADERS}  ${headers}
      Create Session  session  ${apiUrl}  headers=${headers}
      Get JSON Form  ../getToken.json
      ${jsonData}=  Replace Variables  ${JSON_FORM}
      ${actual}=  Post JSON data   /api/users   ${jsonData}  201
      log  ${actual}
      set test variable  ${authorizationToken}      ${actual}
      delete all sessions

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

Post JSON data
      [Arguments]  ${uri}  ${JSONdata}  ${statusCode}=201  ${returnType}=content  ${header}=
      ${HEADERS}  ${checkStatus}=true
      [Documentation]  POST the JSON data to given uri. Returns the POSTed JSON data as JSON object.
      log  ${uri}
      log  ${JSONdata}
      ${resp}=  Post Request  session  ${uri}  data=${JSONdata}  headers=${header}
      Log  ${resp.text}
      Log  ${resp.headers}
      Run Keyword If  "${checkStatus}" == "SUCCESS"
      ...  Should Be Equal As Strings  ${resp.status_code}  ${statusCode}
      ${actual}=  Run Keyword If  "${returnType}" == "content"
      ...           To Json  ${resp.content}
      ...         ELSE
      ...           Set Variable  ${resp}
      Log  ${actual}
      [Return]  ${actual}

Delete JSON data
    [Arguments]  ${uri}  ${header}=${HEADERS}  ${expectedStatusCode}=204
    [Documentation]  Sends a delete request to given uri.
    log  ${uri}
    ${resp}=  Delete Request  session  ${uri}  headers=${headers}  #data=${JSONdata}
    Should Be Equal As Strings  ${resp.status_code}  ${expectedStatusCode}

Get JSON Form
      [Arguments]  ${formName}  ${location}=${CURDIR}${/}Resources${/}
      [Documentation]  Reads the json template.

