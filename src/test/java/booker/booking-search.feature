@regression
Feature: Search bookings - GET /booking

  Background:
    * url baseUrl
    * def booking = newBooking()
    * def created = call read('classpath:booker/common/create-booking.feature') { booking: '#(booking)' }
    * def id = created.bookingId

  Scenario: filter by first and last name finds the new booking
    Given path 'booking'
    And param firstname = booking.firstname
    And param lastname = booking.lastname
    When method get
    Then status 200
    And match response == '#[_ > 0]'
    And match each response == { bookingid: '#number' }
    And match response contains { bookingid: '#(id)' }
    * call read('classpath:booker/common/delete-booking.feature') { bookingId: '#(id)' }

  Scenario: an unknown name returns an empty list
    Given path 'booking'
    And param lastname = 'NoSuchGuest-' + java.util.UUID.randomUUID()
    When method get
    Then status 200
    And match response == []
    * call read('classpath:booker/common/delete-booking.feature') { bookingId: '#(id)' }
