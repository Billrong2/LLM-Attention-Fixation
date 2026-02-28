

public class C_b98834b5 {

    public static void main(String[] p_0OlOO1) {
        Node _0I1II1 = new Node();
        _0I1II1.left = new Node();
        _0I1II1.right = new Node();
        _0I1II1.left.left = new Node();
        _0I1II1.left.left.left = new Node();
        _0I1II1.left.left.right = new Node();
        System.out.println(getHeightOfTree(_0I1II1));
    }

    public static class Node {
        public Node left, right;
        int value;
    }

    public static int getHeightOfTree(Node p_lllI11) {
        if (p_lllI11.left == null && p_lllI11.right == null) {
            return 1;
        }
        if (p_lllI11.left == null) {
            return 1 + getHeightOfTree(p_lllI11.right);
        }
        if (p_lllI11.right == null) {
            return 1 + getHeightOfTree(p_lllI11.left);
        }
        return 1 + Math.max(getHeightOfTree(p_lllI11.left), getHeightOfTree(p_lllI11.right));
    }
}
