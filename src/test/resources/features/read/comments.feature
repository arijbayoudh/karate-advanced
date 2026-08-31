##@Test
Feature: Comments API Tests

  Background:
    * url 'https://jsonplaceholder.typicode.com/'
    * header Accept = 'application/json'


  # ============================================================
  # GET ALL COMMENTS
  # ============================================================

  Scenario: Get all comments
    Given path 'comments'
    When method GET
    Then status 200

    # Vérifier que la réponse est un tableau
    And match response == '#[]'

    # Vérifier la structure de chaque commentaire
    And match each response ==
      """
      {
        postId: '#number',
        id: '#number',
        name: '#string',
        email: '#string',
        body: '#string'
      }
      """

    # Vérifier le nombre de commentaires
    And match response == '#[500]'


  # ============================================================
  # GET COMMENT BY ID
  # ============================================================

  Scenario: Get comment by ID
    Given path 'comments', 1
    When method GET
    Then status 200

    # Vérification des champs
    And match response.id == 1
    And match response.postId == '#number'
    And match response.name == '#string'
    And match response.email == '#string'
    And match response.body == '#string'


  # ============================================================
  # GET COMMENT - VALIDATE COMPLETE RESPONSE
  # ============================================================

  Scenario: Get comment 1 with exact values
    Given path 'comments', 1
    When method GET
    Then status 200

    And match response ==
      """
      {
        postId: 1,
        id: 1,
        name: 'id labore ex et quam laborum',
        email: 'Eliseo@gardner.biz',
        body: '#string'
      }
      """


  # ============================================================
  # GET COMMENTS BY POST ID
  # ============================================================

  Scenario: Get comments by postId
    Given path 'comments'
    And param postId = 1
    When method GET
    Then status 200

    # Vérifier que la réponse est un tableau
    And match response == '#[]'

    # Tous les commentaires doivent appartenir au post 1
    And match each response contains
      """
      {
        postId: 1
      }
      """

    # Vérifier la structure
    And match each response ==
      """
      {
        postId: '#number',
        id: '#number',
        name: '#string',
        email: '#string',
        body: '#string'
      }
      """


  # ============================================================
  # GET COMMENTS - NESTED RESOURCE
  # ============================================================

  Scenario: Get comments of a specific post using nested endpoint
    Given path 'posts', 1, 'comments'
    When method GET
    Then status 200

    And match response == '#[]'

    # Tous les commentaires doivent avoir postId = 1
    And match each response contains
      """
      {
        postId: 1
      }
      """


  # ============================================================
  # GET COMMENT - INVALID ID
  # ============================================================

  Scenario: Get comment with non existing ID
    Given path 'comments', 9999
    When method GET
    Then status 404


  # ============================================================
  # CREATE COMMENT
  # ============================================================

  Scenario: Create a new comment
    Given path 'comments'

    And request
      """
      {
    "postId": 1,
    "name": "Karate Test",
    "email": "karate@test.com",
    "body": "This comment was created using Karate"
    }
    """

    And header Content-Type = 'application/json'

    When method POST
    Then status 201

    # Vérification des données retournées
    And match response.postId == 1
    And match response.name == 'Karate Test'
    And match response.email == 'karate@test.com'
    And match response.body == 'This comment was created using Karate'

    # ID généré
    And match response.id == '#number'


  # ============================================================
  # UPDATE COMMENT - PUT
  # ============================================================

  Scenario: Update a comment with PUT
    Given path 'comments', 1

    And request
      """
      {
    "id": 1,
    "postId": 1,
    "name": "Updated Comment",
    "email": "updated@test.com",
    "body": "Updated comment body"
    }
    """

    And header Content-Type = 'application/json'

    When method PUT
    Then status 200

    And match response.id == 1
    And match response.postId == 1
    And match response.name == 'Updated Comment'
    And match response.email == 'updated@test.com'
    And match response.body == 'Updated comment body'


  # ============================================================
  # UPDATE COMMENT - PATCH
  # ============================================================

  Scenario: Update only the body of a comment
    Given path 'comments', 1

    And request
      """
      {
        "body": "Body updated with PATCH"
      }
      """

    And header Content-Type = 'application/json'

    When method PATCH
    Then status 200

    And match response.id == 1
    And match response.body == 'Body updated with PATCH'


  # ============================================================
  # DELETE COMMENT
  # ============================================================

  Scenario: Delete a comment
    Given path 'comments', 1
    When method DELETE
    Then status 200

    #Exercices:
    #Devide between Get and Post files
    #Exchange with best practice