function fn() {
  var env = karate.env || 'prod';
  karate.log('karate.env =', env);

  var config = {
    env: env,
    baseUrl: karate.properties['baseUrl'] || 'https://restful-booker.herokuapp.com',
    username: karate.properties['booker.user'] || 'admin',
    password: karate.properties['booker.password'] || 'password123'
  };

  // public demo API: can be slow on a cold start
  karate.configure('connectTimeout', 15000);
  karate.configure('readTimeout', 30000);
  // the API returns 418 for POST /booking without an explicit Accept header
  karate.configure('headers', { Accept: 'application/json', 'Content-Type': 'application/json' });

  // one token for the whole parallel run
  config.token = karate.callSingle('classpath:booker/common/auth.feature', config).token;
  config.newBooking = read('classpath:booker/data/booking-factory.js');
  config.bookingSchema = read('classpath:booker/data/booking-schema.json');
  return config;
}
