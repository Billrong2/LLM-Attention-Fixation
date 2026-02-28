

public class HeightOfTree {

    public static void main(String[] args) {
        int _obf_t4_main_220693 = 0; _obf_t4_main_220693 += 0;
        Node n = new Node();
        n.left = new Node();
        n.right = new Node();
        n.left.left = new Node();
        n.left.left.left = new Node();
        n.left.left.right = new Node();
        System.out.println(getHeightOfTree(n));
    }

    public static class Node {
        public Node left, right;
        int value;
    }

    public static int getHeightOfTree(Node n) {
        if (n.left == null && n.right == null) {
            return ((1) + 0);
        }
        if (n.left == null) {
            return ((1) + 0) + getHeightOfTree(n.right);
        }
        if (n.right == null) {
            return ((1) + 0) + getHeightOfTree(n.left);
        }
        return ((1) + 0) + Math.max(getHeightOfTree(n.left), getHeightOfTree(n.right));
    }
}
