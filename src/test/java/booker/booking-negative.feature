@regression @negative
Feature: Negative and security checks

  Background:
    * url baseUrl
    * def created = call read('classpath:booker/common/create-booking.feature') { booking: '#(newBooking())' }
    * def id = created.bookingId

  Scenario: update without a token is forbidden
    Given path 'booking', id
    And request newBooking()
    When method put
    Then status 403

  Scenario: update with an invalid token is forbidden
    Given path 'booking', id
    And cookie token = 'not-a-real-token'
    And request newBooking()
    When method put
    Then status 403

  Scenario: delete without a token is forbidden and the booking survives
    Given path 'booking', id
    When method delete
    Then status 403
    Given path 'booking', id
    When method get
    Then status 200

  Scenario: a booking that does not exist returns 404
    Given path 'booking', 999999999
    When method get
    Then status 404

  @knownbug
  Scenario: create with missing required fields should be a 400
    # DEFECT: the API returns 500 Internal Server Error instead of a 400 validation error
    Given path 'booking'
    And request { firstname: 'OnlyFirstName' }
    When method post
    Then status 400

  @knownbug
  Scenario: checkout before checkin should be rejected
    # DEFECT: the API accepts impossible date ranges
    Given path 'booking'
    And request newBooking({ bookingdates: { checkin: '2026-11-10', checkout: '2026-11-01' } })
    When method post
    Then status 400
