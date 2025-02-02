import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Queue;
import java.util.Scanner;

class LinkedList implements Queue<String> {
    static class Node {
        int data;
        Node next;

        Node(int data) {
            this.data = data;
            this.next = null;
        }
    }

    public static boolean hasCycle(Node head) {
        Node slow = head, fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
            if (slow == fast) return true;
        }
        return false;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter number of nodes: ");
        int n = scanner.nextInt();

        if (n == 0) {
            System.out.println("No cycle: Empty list");
            return;
        }

        Node head = new Node(scanner.nextInt());
        Node current = head;
        Node cycleNode = null;

        for (int i = 1; i < n; i++) {
            Node newNode = new Node(scanner.nextInt());
            current.next = newNode;
            current = newNode;

            if (i == n / 2) cycleNode = newNode; // Marking a node for cycle creation
        }

        System.out.print("Create cycle? (yes/no): ");
        String createCycle = scanner.next();

        if (createCycle.equalsIgnoreCase("yes")) {
            current.next = cycleNode;
            System.out.println("Cycle created.");
        }

        System.out.println("Has cycle: " + hasCycle(head));
        scanner.close();
    }

	@Override
	public boolean addAll(Collection<? extends String> arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void clear() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean contains(Object arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean containsAll(Collection<?> arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isEmpty() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Iterator<String> iterator() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean remove(Object arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean removeAll(Collection<?> arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean retainAll(Collection<?> arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public int size() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Object[] toArray() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public <T> T[] toArray(T[] arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean add(String arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String element() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean offer(String arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String peek() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String poll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String remove() {
		// TODO Auto-generated method stub
		return null;
	}
}