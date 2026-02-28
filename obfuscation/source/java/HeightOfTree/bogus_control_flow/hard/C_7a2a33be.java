

public class C_7a2a33be {

    public static void main(String[] args) {
        int _obf_t5_main_393569 = 0; _obf_t5_main_393569 += 0;
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
        int _obf_t5_getHeightOfTree_882141 = 0; _obf_t5_getHeightOfTree_882141 += 0;
        if (n.left == null && n.right == null) {
            return 1;
        }
        if (n.left == null) {
            return 1 + getHeightOfTree(n.right);
        }
        if (n.right == null) {
            return 1 + getHeightOfTree(n.left);
        }
        return 1 + Math.max(getHeightOfTree(n.left), getHeightOfTree(n.right));
    }
}
