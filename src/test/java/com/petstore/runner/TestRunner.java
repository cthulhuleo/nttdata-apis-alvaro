package com.petstore.runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.AfterAll;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

class TestRunner {

    @BeforeAll
    static void setup() {
        System.setProperty("karate.env", "dev");
    }

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:features")
                .outputCucumberJson(true)
                .tags("~@ignore")
                .parallel(1);

        generateReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:features").relativeTo(getClass());
    }

    @Karate.Test
    Karate testPetCRUD() {
        return Karate.run("classpath:features/petTests.feature")
                .tags("@crud")
                .relativeTo(getClass());
    }

    @Karate.Test
    Karate testNegative() {
        return Karate.run("classpath:features/petTests.feature")
                .tags("@negative")
                .relativeTo(getClass());
    }

    private static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(
                new File(karateOutputPath),
                new String[]{"json"},
                true
        );

        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        for (File file : jsonFiles) {
            jsonPaths.add(file.getAbsolutePath());
        }

        Configuration config = new Configuration(
                new File("build/cucumber-reports"),
                "PetStore API Tests"
        );

        config.addClassifications("Platform", System.getProperty("os.name"));
        config.addClassifications("Java Version", System.getProperty("java.version"));
        config.addClassifications("Gradle Version", "7.6.1");
        config.addClassifications("Karate Version", "1.4.1");

        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}