@Test
Feature: Delete Photos Tests
  Background:
    * url baseUrl
    # * configure headers = {Authorization: 'Bearer ' + token}
    * header Content-Type = 'application/json'

  Scenario: DELETE Photo
    Given path 'photos', 1
    When method DELETE
    Then status 200
    And match response =={}