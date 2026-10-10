package booker;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class BookerTest {

    @Test
    void runAllFeatures() {
        // @knownbug scenarios document real API defects; run them with -Dkarate.options="--tags @knownbug"
        Results results = Runner.path("classpath:booker")
                .tags("~@knownbug", "~@ignore")
                .outputCucumberJson(true)
                .parallel(Integer.getInteger("threads", 4));
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
