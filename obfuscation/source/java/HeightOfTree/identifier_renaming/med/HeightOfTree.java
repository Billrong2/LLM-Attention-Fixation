

public class HeightOfTree {

    public static void main(String[] _p1) {
        Node _o1 = new Node();
        _o1.left = new Node();
        _o1.right = new Node();
        _o1.left.left = new Node();
        _o1.left.left.left = new Node();
        _o1.left.left.right = new Node();
        System.out.println(getHeightOfTree(_o1));
    }

    public static class Node {
        public Node left, right;
        int value;
    }

    public static int getHeightOfTree(Node _p1) {
        if (_p1.left == null && _p1.right == null) {
            return 1;
        }
        if (_p1.left == null) {
            return 1 + getHeightOfTree(_p1.right);
        }
        if (_p1.right == null) {
            return 1 + getHeightOfTree(_p1.left);
        }
        return 1 + Math.max(getHeightOfTree(_p1.left), getHeightOfTree(_p1.right));
    }
}
