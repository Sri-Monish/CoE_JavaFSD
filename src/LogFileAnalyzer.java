import java.io.*;
import java.util.*;

class LogFileAnalyzer {
    public static void analyzeLogFile(String inputFile, String outputFile, List<String> keywords) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {

            String line;
            Map<String, Integer> counts = new HashMap<>();

            while ((line = reader.readLine()) != null) {
                for (String keyword : keywords) {
                    if (line.contains(keyword)) {
                        counts.put(keyword, counts.getOrDefault(keyword, 0) + 1);
                        writer.write(line + "\n");
                    }
                }
            }

            writer.write("\nSummary:\n");
            for (String keyword : counts.keySet()) writer.write(keyword + ": " + counts.get(keyword) + " occurrences\n");
        }
    }

    public static void main(String[] args) throws IOException {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter input log file path: ");
        String inputFile = scanner.nextLine();

        System.out.print("Enter output file path: ");
        String outputFile = scanner.nextLine();

        System.out.print("Enter keywords (comma-separated): ");
        List<String> keywords = Arrays.asList(scanner.nextLine().split(","));

        analyzeLogFile(inputFile, outputFile, keywords);
        System.out.println("Log analysis complete. Results saved to " + outputFile);
        scanner.close();
    }
}