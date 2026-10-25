@Test
Feature: Comments API Tests

  Background:
    * url 'https://jsonplaceholder.typicode.com/'
    * header Accept = 'application/json'
    * def commentSchema = read('classpath:features/data/request/comment-schema.json')

  # ============================================================
  # GET ALL COMMENTS
  # ============================================================

  Scenario: Get all comments
    Given path 'comments'
    When method GET
    Then status 200

    And match response == '#[500]'
    And match each response == commentSchema


  # ============================================================
  # GET COMMENT BY ID
  # ============================================================

  Scenario: Get comment by ID
    Given path 'comments', 1
    When method GET
    Then status 200

    And match response == commentSchema
    And match response.id == 1


  # ============================================================
  # GET COMMENT - VALIDATE EXACT VALUES
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

    And match response == '#[]'
    And match each response contains { postId: 1 }
    And match each response == commentSchema


  # ============================================================
  # GET COMMENTS - NESTED RESOURCE
  # ============================================================

  Scenario: Get comments of a specific post using nested endpoint
    Given path 'posts', 1, 'comments'
    When method GET
    Then status 200

    And match response == '#[]'
    And match each response contains { postId: 1 }
    And match each response == commentSchema


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

    * def commentPayload = read('classpath:features/data/request/comments.json')
    And request commentPayload

    And header Content-Type = 'application/json'
    When method POST
    Then status 201

    And match response.postId == commentPayload.postId
    And match response.name == commentPayload.name
    And match response.email == commentPayload.email
    And match response.body == commentPayload.body
    And match response.id == '#number'


  # ============================================================
  # UPDATE COMMENT - PUT
  # ============================================================

  Scenario: Update a comment with PUT
    Given path 'comments', 1

    * def updatePayload =
      """
      {
        "id": 1,
        "postId": 1,
        "name": "Updated Comment",
        "email": "updated@test.com",
        "body": "Updated comment body"
      }
      """
    And request updatePayload

    And header Content-Type = 'application/json'
    When method PUT
    Then status 200

    And match response == updatePayload


  # ============================================================
  # UPDATE COMMENT - PATCH
  # ============================================================

  Scenario: Update only the body of a comment
    Given path 'comments', 1

    * def patchPayload =
      """
      {
        "body": "Body updated with PATCH"
      }
      """
    And request patchPayload

    And header Content-Type = 'application/json'
    When method PATCH
    Then status 200

    And match response.id == 1
    And match response.body == patchPayload.body


  # ============================================================
  # DELETE COMMENT
  # ============================================================

  Scenario: Delete a comment
    Given path 'comments', 1
    When method DELETE
    Then status 200
