@regression
Feature: Booking lifecycle - create, read, update, patch, delete

  Background:
    * url baseUrl
    * def booking = newBooking()

  Scenario: a booking can be managed end to end
    # create
    Given path 'booking'
    And request booking
    When method post
    Then status 200
    And match response == { bookingid: '#number', booking: '#(bookingSchema)' }
    And match response.booking == booking
    * def id = response.bookingid

    # read
    Given path 'booking', id
    When method get
    Then status 200
    And match response == booking

    # full update
    * def updated = newBooking({ firstname: 'Updated', totalprice: 300, depositpaid: false })
    Given path 'booking', id
    And cookie token = token
    And request updated
    When method put
    Then status 200
    And match response == updated

    # partial update
    Given path 'booking', id
    And cookie token = token
    And request { additionalneeds: 'Dinner' }
    When method patch
    Then status 200
    And match response == karate.merge(updated, { additionalneeds: 'Dinner' })

    # delete
    Given path 'booking', id
    And cookie token = token
    When method delete
    Then status 201

    # gone
    Given path 'booking', id
    When method get
    Then status 404
