function(overrides) {
  // unique names so parallel runs and search tests never collide
  var suffix = java.util.UUID.randomUUID().toString().substring(0, 8);
  var booking = {
    firstname: 'Karate',
    lastname: 'Tester-' + suffix,
    totalprice: 150,
    depositpaid: true,
    bookingdates: { checkin: '2026-11-01', checkout: '2026-11-05' },
    additionalneeds: 'Breakfast'
  };
  return karate.merge(booking, overrides || {});
}
