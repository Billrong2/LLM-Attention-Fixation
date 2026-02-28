

public class HeightOfTree {

    public static void main(String[] args) {
        Node n = new Node();
        n.left = new Node();
        n.right = new Node();
        n.left.left = new Node();
        n.left.left.left = new Node();
        n.left.left.right = new Node();
        System.out.println(_obf_t8_getHeightOfTree_544813(n));
    }

    public static class Node {
        public Node left, right;
        int value;
    }

    public static int getHeightOfTree(Node n) {
        if (n.left == null && n.right == null) {
            return 1;
        }
        if (n.left == null) {
            return 1 + _obf_t8_getHeightOfTree_544813(n.right);
        }
        if (n.right == null) {
            return 1 + _obf_t8_getHeightOfTree_544813(n.left);
        }
        return 1 + Math.max(_obf_t8_getHeightOfTree_544813(n.left), _obf_t8_getHeightOfTree_544813(n.right));
    }


private static int _obf_t8_getHeightOfTree_544813(Node n) {
        return getHeightOfTree(n);
    }
}
