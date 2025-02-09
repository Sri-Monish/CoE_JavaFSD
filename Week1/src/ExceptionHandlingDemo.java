import java.util.Scanner;

class ExceptionHandlingDemo {
    public static void processInput() {
        Scanner scanner = new Scanner(System.in);
        try {
            System.out.print("Enter a number: ");
            double num = Double.parseDouble(scanner.nextLine());
            System.out.println("Reciprocal: " + (1 / num));
        } catch (NumberFormatException e) {
            System.out.println("Invalid input! Please enter a number.");
        } catch (ArithmeticException e) {
            System.out.println("Cannot divide by zero.");
        } finally {
            scanner.close();
        }
    }

    public static void main(String[] args) {
        processInput();
    }
}