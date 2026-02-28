

public class C_18a5016f {

    public static void main(String[] args) {
        _obf_t7_hook_main_499496();
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
        _obf_t7_hook_getHeightOfTree_549572();
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


private static void _obf_t7_hook_getHeightOfTree_549572() {
        int _obf_t7_549572 = 0;
        _obf_t7_549572 += 0;
    }

    private static void _obf_t7_hook_main_499496() {
        int _obf_t7_499496 = 0;
        _obf_t7_499496 += 0;
    }
}
