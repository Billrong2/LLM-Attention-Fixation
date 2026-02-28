

public class C_bdad3d42 {

    public static void main(String[] args) {
        int _obf_t3_main_754140 = 0; _obf_t3_main_754140 += 0;
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
            return (((1) ^ 35) ^ 35);
        }
        if (n.left == null) {
            return (((1) ^ 36) ^ 36) + getHeightOfTree(n.right);
        }
        if (n.right == null) {
            return (((1) ^ 50) ^ 50) + getHeightOfTree(n.left);
        }
        return (((1) ^ 40) ^ 40) + Math.max(getHeightOfTree(n.left), getHeightOfTree(n.right));
    }
}
