@ignore
Feature: Reusable - delete a booking (test data cleanup)

  Scenario:
    Given url baseUrl
    And path 'booking', bookingId
    And cookie token = token
    When method delete
    Then status 201
