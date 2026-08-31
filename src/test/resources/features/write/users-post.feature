@Test
Feature: Post  Users

  Background:
    * url baseUrl
    # * configure headers = {Authorization: 'Bearer ' + token}
    * header Content-Type = 'application/json'
    * def name = randomName()
    * def email = randomEmail()

  Scenario: POST - Create A New User
  * def payload = read('classpath:features/data/request/request-users.json')
    Given path 'users'
    And request payload
#    or use this directly without json file
#    """
#    {
#    "name": "#(name)",
#    "username": "Arij",
#    "email": "#(email)",
#    }
#    """
  When method POST
  Then match responseStatus == httpStatus.success.created
  And match response.id == "#number"