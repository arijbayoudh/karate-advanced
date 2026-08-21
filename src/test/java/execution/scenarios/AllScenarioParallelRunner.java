package execution.scenarios;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

class AllScenarioParallelRunner {

	private static final DecimalFormat df = new DecimalFormat("0.000");

	@Test
	void runAll() {
		Results results = Runner.path("classpath:features")
				.outputCucumberJson(true)
				.outputJunitXml(true)
				.tags("@Test").parallel(5);
		generateReport(results.getReportDir());
		System.out.println("Karate reports are in: " + results.getReportDir());


		System.out.println("resultats_success: " + results.getScenariosPassed());
		System.out.println("resultats_failed: " + results.getFailCount());
		double timeInSeconds = results.getTimeTakenMillis() / 1000.0;
		System.out.println("duree_execution : " + df.format(timeInSeconds) + "s");

		if(results.getErrors() != null) {
			System.out.println("FailedMap: " + results.getErrors());
		}
		else {
			System.out.println("FailedMap: aucun");
		}

		assertEquals(0, results.getFailCount(), results.getErrorMessages());
	}

	public static void generateReport(String karateOutputPath) {
		Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
		List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
		jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
		Configuration config = new Configuration(new File("target"), "tests");
		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
		reportBuilder.generateReports();
	}
}