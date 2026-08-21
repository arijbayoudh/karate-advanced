  @Test
  Feature: Test Get - Récupération des utilisateurs

    Background:
      * url baseUrl
      # * configure headers = {Authorization: 'Bearer ' + token}
      * header Content-Type = 'application/json'

  Scenario: GET - Récupérer tous les utilisateurs avec validation compléte

    Given path 'users'
    When method GET
    Then status 200
    And print response
