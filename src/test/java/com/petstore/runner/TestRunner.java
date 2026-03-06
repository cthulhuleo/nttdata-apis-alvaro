package com.petstore.runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class TestRunner {

    private static final String KARATE_OUTPUT_DIR = "build/karate-reports";
    private static final String CUCUMBER_REPORTS_DIR = "build/cucumber-reports";

    @Test
    void testAllFeatures() {
        Results results = Runner.path("classpath:features")
                .outputCucumberJson(true)
                .karateEnv("dev")
                .parallel(5); // Aumentar paralelismo

        generateCucumberReport();
        assertEquals(0, results.getFailCount(), "Pruebas fallaron: " + results.getErrorMessages());
    }

    @Test
    void testCRUDOnly() {
        Results results = Runner.path("classpath:features/petTests.feature")
                .tags("@crud")
                .outputCucumberJson(true)
                .karateEnv("dev")
                .parallel(3);

        generateCucumberReport();
        assertEquals(0, results.getFailCount(), "Pruebas CRUD fallaron: " + results.getErrorMessages());
    }

    @Test
    void testNegativeOnly() {
        Results results = Runner.path("classpath:features/petTests.feature")
                .tags("@negative")
                .outputCucumberJson(true)
                .karateEnv("dev")
                .parallel(1);

        generateCucumberReport();
        assertEquals(0, results.getFailCount(), "Pruebas negativas fallaron: " + results.getErrorMessages());
    }

    private void generateCucumberReport() {
        try {
            Collection<File> jsonFiles = FileUtils.listFiles(
                    new File(KARATE_OUTPUT_DIR),
                    new String[]{"json"},
                    true
            );

            List<String> jsonPaths = new ArrayList<>();
            jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));

            if (!jsonPaths.isEmpty()) {
                Configuration config = new Configuration(
                        new File(CUCUMBER_REPORTS_DIR),
                        "PetStore API Tests"
                );

                config.setBuildNumber("1.0");
                config.addClassifications("Environment", "Dev");
                config.addClassifications("Browser", "API");
                config.addClassifications("Branch", "main");
                config.addClassifications("JDK", System.getProperty("java.version"));

                ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
                reportBuilder.generateReports();

                System.out.println("Reportes Cucumber generados en: " + CUCUMBER_REPORTS_DIR);
            } else {
                System.out.println("No se encontraron archivos JSON para generar reportes");
            }
        } catch (Exception e) {
            System.err.println("Error generando reportes Cucumber: " + e.getMessage());
        }
    }
}