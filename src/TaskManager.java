import java.util.*;

class Task {
    String id, description;
    int priority;

    public Task(String id, String description, int priority) {
        this.id = id;
        this.description = description;
        this.priority = priority;
    }

    public String toString() {
        return "Task[ID=" + id + ", Priority=" + priority + ", Description=" + description + "]";
    }
}

class TaskManager {
    private PriorityQueue<Task> taskQueue = new PriorityQueue<>(Comparator.comparingInt(t -> -t.priority));
    private Map<String, Task> taskMap = new HashMap<>();

    public void addTask(String id, String description, int priority) {
        Task task = new Task(id, description, priority);
        taskQueue.add(task);
        taskMap.put(id, task);
    }

    public void removeTask(String id) {
        Task task = taskMap.remove(id);
        if (task != null) taskQueue.remove(task);
    }

    public Task getHighestPriorityTask() {
        return taskQueue.peek();
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        TaskManager manager = new TaskManager();

        while (true) {
            System.out.println("\n1. Add Task\n2. Remove Task\n3. Get Highest Priority Task\n4. Exit");
            System.out.print("Choose an option: ");
            int choice = scanner.nextInt();
            scanner.nextLine(); // Consume newline

            switch (choice) {
                case 1:
                    System.out.print("Enter Task ID: ");
                    String id = scanner.nextLine();
                    System.out.print("Enter Description: ");
                    String description = scanner.nextLine();
                    System.out.print("Enter Priority (higher is more important): ");
                    int priority = scanner.nextInt();
                    manager.addTask(id, description, priority);
                    break;
                case 2:
                    System.out.print("Enter Task ID to remove: ");
                    String removeId = scanner.nextLine();
                    manager.removeTask(removeId);
                    break;
                case 3:
                    System.out.println("Highest Priority Task: " + manager.getHighestPriorityTask());
                    break;
                case 4:
                    scanner.close();
                    System.exit(0);
            }
        }
    }
}