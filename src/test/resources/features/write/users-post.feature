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


  Scenario Outline: Create A New User - Outline
    * def payload = read('classpath:features/data/request/users.json')
    * payload.name = '<name>'
    * payload.username = '<username>'
    * payload.email = '<email>'

    Given path 'users'
    And request payload
    When method POST
    Then match responseStatus == httpStatus.success.created
    And match response.id == "#number"
    * def users = read('classpath:features/data/file/users.csv')
    * print users
    
    Examples:
      |name            |username            |email            |
      |#(users[0].name)|#(users[0].username)|#(users[0].email)|
      |#(users[1].name)|#(users[1].username)|#(users[1].email)|
      |#(users[2].name)|#(users[2].username)|#(users[2].email)|




