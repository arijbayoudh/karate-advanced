@Test
Feature: Get  Users

  Background:
    * url baseUrl
    # * configure headers = {Authorization: 'Bearer ' + token}
    * header Content-Type = 'application/json'
    Given path 'users'
    ## or we can write * path 'users'

  Scenario: 1- GET - All Users

    When method GET
    Then status 200

  Scenario: 2- GET - User By Valid ID

    # to navigate to next page
    And param page = 1
    When method GET
    Then status 200
    # match to assert
    And match response[0].id == 1
    And match response[0].email == 'Sincere@april.biz'

  Scenario: 3- GET - Users By Invalid ID

    And param page = 30
    When method GET
    Then status 404

  Scenario: 4- GET - Validate All User Fields

    When method GET
    Then status 200
    # match each to assert all
    And match each response[*].id == '#number'
    And match each response[*].name == '#string'
    And match each response[*].email == '#string'
    And match each response[*].address.street == '#string'
    And match each response[*].address.suite == '#notnull'