

public class HeightOfTree {

    public static void main(String[] args) {
        int _obf_t6_state_main_81635 = 0;
        while (_obf_t6_state_main_81635 == 0) {
            _obf_t6_state_main_81635 = 1;
            break;
        }
        do {
                    Node n = new Node();
                    n.left = new Node();
                    n.right = new Node();
                    n.left.left = new Node();
                    n.left.left.left = new Node();
                    n.left.left.right = new Node();
                    System.out.println(getHeightOfTree(n));
                    
        } while (false);
}

    public static class Node {
        public Node left, right;
        int value;
    }

    public static int getHeightOfTree(Node n) {
        int _obf_t6_getHeightOfTree_683557 = 0; _obf_t6_getHeightOfTree_683557 += 0;
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
