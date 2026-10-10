@regression
Feature: Create booking - data driven from data/bookings.json

  Background:
    * url baseUrl

  Scenario Outline: create a booking: ${label}
    * def booking = newBooking({ totalprice: totalprice, depositpaid: depositpaid, additionalneeds: additionalneeds })
    Given path 'booking'
    And request booking
    When method post
    Then status 200
    And match response.booking == bookingSchema
    And match response.booking == booking
    And call read('classpath:booker/common/delete-booking.feature') { bookingId: '#(response.bookingid)' }

    Examples:
      | read('classpath:booker/data/bookings.json') |
