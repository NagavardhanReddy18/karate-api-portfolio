@smoke
Feature: Authentication - POST /auth

  Background:
    * url baseUrl
    * path 'auth'

  Scenario: valid credentials return a token
    Given request { username: '#(username)', password: '#(password)' }
    When method post
    Then status 200
    And match response == { token: '#string' }
    And assert response.token.length > 0

  Scenario Outline: invalid credentials are rejected - <label>
    Given request { username: '<user>', password: '<pass>' }
    When method post
    # the API answers 200 with a reason instead of 401
    Then status 200
    And match response == { reason: 'Bad credentials' }
    And match response !contains { token: '#notnull' }

    Examples:
      | label          | user   | pass        |
      | wrong password | admin  | wrong       |
      | unknown user   | nobody | password123 |
      | wrong case     | ADMIN  | password123 |
