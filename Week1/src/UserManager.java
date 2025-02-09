import java.io.*;
import java.util.*;

class UserManager {
    private List<String> users = new ArrayList<>();

    public void addUser(String name, String email) {
        users.add(name + "," + email);
    }

    public void saveUsersToFile(String filename) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename))) {
            for (String user : users) writer.write(user + "\n");
        }
    }

    public void loadUsersFromFile(String filename) throws IOException {
        users.clear();
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = reader.readLine()) != null) users.add(line);
        }
    }

    public static void main(String[] args) throws IOException {
        Scanner scanner = new Scanner(System.in);
        UserManager manager = new UserManager();
        String filename = "users.txt";

        while (true) {
            System.out.println("\n1. Add User\n2. Save Users to File\n3. Load Users from File\n4. Display Users\n5. Exit");
            System.out.print("Choose an option: ");
            int choice = scanner.nextInt();
            scanner.nextLine();

            if (choice == 1) {
                System.out.print("Enter Name: ");
                String name = scanner.nextLine();
                System.out.print("Enter Email: ");
                String email = scanner.nextLine();
                manager.addUser(name, email);
            } else if (choice == 2) {
                manager.saveUsersToFile(filename);
                System.out.println("Users saved to file.");
            } else if (choice == 3) {
                manager.loadUsersFromFile(filename);
                System.out.println("Users loaded from file.");
            } else if (choice == 4) {
                System.out.println("User List:");
                for (String user : manager.users) System.out.println(user);
            } else if (choice == 5) {
                break;
            }
        }
        scanner.close();
    }
}