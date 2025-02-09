import java.util.*;

class TreeNode {
    int val;
    TreeNode left, right;

    TreeNode(int val) {
        this.val = val;
        this.left = this.right = null;
    }
}

class BinaryTreeSerialization {
    public static String serialize(TreeNode root) {
        if (root == null) return "null,";
        return root.val + "," + serialize(root.left) + serialize(root.right);
    }

    public static TreeNode deserialize(String data) {
        Queue<String> nodes = new LinkedList(Arrays.asList(data.split(",")));
        return buildTree(nodes);
    }

    private static TreeNode buildTree(Queue<String> nodes) {
        String val = nodes.poll();
        if (val.equals("null")) return null;
        TreeNode node = new TreeNode(Integer.parseInt(val));
        node.left = buildTree(nodes);
        node.right = buildTree(nodes);
        return node;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter tree node values (comma-separated, use 'null' for missing nodes): ");
        String input = scanner.nextLine();

        TreeNode root = deserialize(input);
        System.out.println("Serialized Tree: " + serialize(root));
        scanner.close();
    }
}