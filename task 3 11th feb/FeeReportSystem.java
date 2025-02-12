import java.sql.*;
import java.util.Scanner;

public class FeeReportSystem {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/feereport";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";
    private static Connection connection;
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        try {
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Database Connected Successfully.");
            loginMenu();
        } catch (SQLException e) {
            System.out.println("Database Connection Failed: " + e.getMessage());
        }
    }

    private static void loginMenu() {
        while (true) {
            System.out.println("\n1. Admin Login\n2. Accountant Login\n3. Exit");
            System.out.print("Choose an option: ");
            int choice = scanner.nextInt();
            scanner.nextLine();
            switch (choice) {
                case 1: adminLogin(); break;
                case 2: accountantLogin(); break;
                case 3: System.exit(0);
                default: System.out.println("Invalid Choice!");
            }
        }
    }

    private static void adminLogin() {
        System.out.print("Enter Username: ");
        String username = scanner.nextLine();
        System.out.print("Enter Password: ");
        String password = scanner.nextLine();
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM admin WHERE username=? AND password=?");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("Admin Login Successful!");
                adminMenu();
            } else {
                System.out.println("Invalid Credentials!");
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    private static void adminMenu() {
        while (true) {
            System.out.println("\n1. Add Accountant\n2. View Accountants\n3. Delete Accountant\n4. Logout");
            System.out.print("Choose an option: ");
            int choice = scanner.nextInt();
            scanner.nextLine();
            switch (choice) {
                case 1: addAccountant(); break;
                case 2: viewAccountants(); break;
                case 3: deleteAccountant(); break;
                case 4: return;
                default: System.out.println("Invalid Choice!");
            }
        }
    }

    private static void addAccountant() {
        System.out.print("Enter Name: ");
        String name = scanner.nextLine();
        System.out.print("Enter Email: ");
        String email = scanner.nextLine();
        System.out.print("Enter Phone: ");
        String phone = scanner.nextLine();
        System.out.print("Enter Password: ");
        String password = scanner.nextLine();
        try {
            PreparedStatement ps = connection.prepareStatement("INSERT INTO accountant (name, email, phone, password) VALUES (?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, password);
            ps.executeUpdate();
            System.out.println("Accountant Added Successfully!");
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    private static void viewAccountants() {
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM accountant");
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("id") + " | Name: " + rs.getString("name") + " | Email: " + rs.getString("email") + " | Phone: " + rs.getString("phone"));
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    private static void deleteAccountant() {
        System.out.print("Enter Accountant ID to Delete: ");
        int id = scanner.nextInt();
        try {
            PreparedStatement ps = connection.prepareStatement("DELETE FROM accountant WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Accountant Deleted Successfully!");
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    private static void accountantLogin() {
        System.out.print("Enter Email: ");
        String email = scanner.nextLine();
        System.out.print("Enter Password: ");
        String password = scanner.nextLine();
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM accountant WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("Accountant Login Successful!");
                accountantMenu();
            } else {
                System.out.println("Invalid Credentials!");
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    private static void accountantMenu() {
        while (true) {
            System.out.println("\n1. Add Student\n2. View Students\n3. Check Due Fee\n4. Logout");
            System.out.print("Choose an option: ");
            int choice = scanner.nextInt();
            scanner.nextLine();
            switch (choice) {
                case 1: addStudent(); break;
                case 2: viewStudents(); break;
                case 3: checkDueFee(); break;
                case 4: return;
                default: System.out.println("Invalid Choice!");
            }
        }
    }

    public static void checkDueFee() {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM student WHERE due > 0");
             ResultSet rs = pstmt.executeQuery()) {

            System.out.println("-----------------------------------------------------------");
            System.out.printf("%-5s %-20s %-25s %-10s %-10s %-10s %-10s %-10s\n",
                    "ID", "Name", "Email", "Course", "Fee", "Paid", "Due", "Phone");
            System.out.println("-----------------------------------------------------------");

            boolean hasDue = false;
            while (rs.next()) {
                hasDue = true;
                System.out.printf("%-5d %-20s %-25s %-10s %-10.2f %-10.2f %-10.2f %-10s\n",
                        rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("course"), rs.getDouble("fee"), rs.getDouble("paid"),
                        rs.getDouble("due"), rs.getString("phone"));
            }

            if (!hasDue) {
                System.out.println("No students with due fees.");
            }

            System.out.println("-----------------------------------------------------------");
        } catch (SQLException e) {
            System.out.println("Error fetching due fee records: " + e.getMessage());
        }
    }


    public static void viewStudents() {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM student")) {

            System.out.println("-----------------------------------------------------------");
            System.out.printf("%-5s %-20s %-25s %-10s %-10s %-10s %-10s %-10s\n",
                    "ID", "Name", "Email", "Course", "Fee", "Paid", "Due", "Phone");
            System.out.println("-----------------------------------------------------------");

            while (rs.next()) {
                System.out.printf("%-5d %-20s %-25s %-10s %-10.2f %-10.2f %-10.2f %-10s\n",
                        rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("course"), rs.getDouble("fee"), rs.getDouble("paid"),
                        rs.getDouble("due"), rs.getString("phone"));
            }

            System.out.println("-----------------------------------------------------------");
        } catch (SQLException e) {
            System.out.println("Error fetching student records: " + e.getMessage());
        }
    }


	private static void addStudent() {
        System.out.print("Enter Name: ");
        String name = scanner.nextLine();
        System.out.print("Enter Email: ");
        String email = scanner.nextLine();
        System.out.print("Enter Course: ");
        String course = scanner.nextLine();
        System.out.print("Enter Fee: ");
        double fee = scanner.nextDouble();
        System.out.print("Enter Paid Amount: ");
        double paid = scanner.nextDouble();
        scanner.nextLine();
        double due = fee - paid;
        System.out.print("Enter Address: ");
        String address = scanner.nextLine();
        System.out.print("Enter Phone: ");
        String phone = scanner.nextLine();
        try {
            PreparedStatement ps = connection.prepareStatement("INSERT INTO student (name, email, course, fee, paid, due, address, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, course);
            ps.setDouble(4, fee);
            ps.setDouble(5, paid);
            ps.setDouble(6, due);
            ps.setString(7, address);
            ps.setString(8, phone);
            ps.executeUpdate();
            System.out.println("Student Added Successfully!");
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
