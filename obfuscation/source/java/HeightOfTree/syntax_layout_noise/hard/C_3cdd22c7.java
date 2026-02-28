

public class C_3cdd22c7 {

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_897432 = 0;
                _obf_t2_897432 += 0;
            }
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
            if (((2 * 2) == 4)) {
                int _obf_t2_183739 = 0;
                _obf_t2_183739 += 0;
            }
        if (n.left == null && n.right == null) {
            return ((1));
        }
        if (n.left == null) {
            return ((1 + getHeightOfTree(n.right)));
        }
        if (n.right == null) {
            return ((1 + getHeightOfTree(n.left)));
        }
        return ((1 + Math.max(getHeightOfTree(n.left), getHeightOfTree(n.right))));
    }
}
