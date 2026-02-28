

public class HeightOfTree {

    public static void main(String[] args) {
        Node v1 = new Node();
        v1.left = new Node();
        v1.right = new Node();
        v1.left.left = new Node();
        v1.left.left.left = new Node();
        v1.left.left.right = new Node();
        System.out.println(getHeightOfTree(v1));
    }

    public static class Node {
        public Node left, right;
        int value;
    }

    public static int getHeightOfTree(Node n) {
        int _obf_t1_getHeightOfTree_250677 = 0; _obf_t1_getHeightOfTree_250677 += 0;
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
