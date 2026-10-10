@ignore
Feature: Reusable - create a booking and return its id

  Scenario:
    Given url baseUrl
    And path 'booking'
    And request booking
    When method post
    Then status 200
    * def bookingId = response.bookingid
