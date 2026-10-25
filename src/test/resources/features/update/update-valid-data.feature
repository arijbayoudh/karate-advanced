@Test
Feature: Update User With Valid Data
  Background:
    * url baseUrl
    # * configure headers = {Authorization: 'Bearer ' + token}
    * header Content-Type = 'application/json'

  Scenario: Update A Post With  Valid Data
    Given path 'posts', 1
    #or you can write instead of , 1 ==> And param page = 1
    * def payload = read('classpath:features/data/request/update-post-valid.json')
    When method PUT
    * match responseStatus == httpStatus.success.ok
    And print responseStatus
    And print payload
    And match response.id ==1
    #The update can work on test environment
    #And match response.title == payload.title
    #And match response.body == payload.body
    #And match response.userId == payload.userId



