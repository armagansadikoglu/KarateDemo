package reqres;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class TestRunner {

    @Test
    void testParallel() {
        // path feature dosyalarının olduğu yer
        // parallel testlerin kaç threade paralel koşulacağı -> paralel koşum istemiyorsanız silebilirsiniz
        Results results = Runner.path("classpath:reqres/features")
                //.outputCucumberJson(true)
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
