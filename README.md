# Restful-Booker API Test Suite (Karate)

![API tests](https://github.com/NagavardhanReddy18/karate-api-portfolio/actions/workflows/api-tests.yml/badge.svg)

Automated API tests for the public [Restful-Booker](https://restful-booker.herokuapp.com/apidoc/index.html) hotel booking API, written in [Karate](https://github.com/karatelabs/karate) and run in parallel in CI.

**16 scenarios · 6 features · about 20 seconds in parallel · 2 real API defects found and documented**

## What it covers

| Area | Feature | What is checked |
| --- | --- | --- |
| Health | `health.feature` | API is up (`GET /ping`) |
| Auth | `auth.feature` | Token issued for valid credentials; data-driven rejection of bad credentials |
| Lifecycle | `booking-crud.feature` | Create → read → full update → partial update → delete → 404, with schema validation |
| Data-driven create | `booking-create.feature` | Bookings built from `data/bookings.json` (deposit, zero and high prices) |
| Search | `booking-search.feature` | Filter by name finds the new booking; unknown name returns `[]` |
| Security / negative | `booking-negative.feature` | 403 without or with a bad token, delete is blocked, 404 for missing ids |

## Defects found

Scenarios tagged `@knownbug` describe the correct behaviour and fail on purpose against the current API. They are excluded from the normal run so CI stays green.

| Defect | Expected | Actual |
| --- | --- | --- |
| `POST /booking` with missing required fields | 400 validation error | **500 Internal Server Error** |
| `POST /booking` with checkout before checkin | 400 validation error | **200**, booking created |

## Design choices

- **One auth token per run** through `karate.callSingle`, shared safely across parallel threads.
- **Unique test data** from `data/booking-factory.js` (UUID suffix), so parallel runs never collide.
- **Reusable features** in `common/` for auth, create and delete. Every test cleans up the bookings it creates.
- **Schema as data** in `data/booking-schema.json`, reused by every response check.
- **Config by system property**: `-DbaseUrl=...` points the suite at another environment with no code change.

## Run it

Requires Java 17+ and Maven 3.8+.

```bash
mvn test                                          # full suite, 4 threads
mvn test -Dkarate.options="--tags @smoke"         # smoke tests only
mvn test -Dkarate.options="--tags @knownbug"      # show the documented defects
mvn test -Dthreads=8 -DbaseUrl=http://localhost:3001
```

The HTML report is written to `target/karate-reports/karate-summary.html`.

## CI

- **GitHub Actions** (`.github/workflows/api-tests.yml`) runs on every push and pull request and once a day, and uploads the HTML report as an artifact.
- **Jenkins** (`Jenkinsfile`) runs a daily cron with an optional `TAGS` parameter, and publishes JUnit results and the Karate report.

## Project layout

```
src/test/java/
├── karate-config.js            # base URL, timeouts, headers, shared token
├── logback-test.xml
└── booker/
    ├── BookerTest.java         # JUnit 5 parallel runner
    ├── *.feature               # test features
    ├── common/                 # reusable auth / create / delete
    └── data/                   # factory, schema, test data
```

---

Built by **[Your Name]** · Software developer & QA automation engineer, available for backend development, API test automation and CI/CD contract work · [LinkedIn](https://linkedin.com/in/YOUR_PROFILE) · [Upwork](https://www.upwork.com/freelancers/YOUR_PROFILE)
