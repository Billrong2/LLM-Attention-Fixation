class DropNumber {

    public static void main(String[] _p1) {
        System.out.println("");
        System.out.println("1 3 4");
        System.out.println("");
        System.out.println("8 8 4");
        System.out.println("");
        int[] values = {8, 8, 1, 3, 4};
        int[] middle = dropNumber(values, 3);
        int[] out = dropNumber(middle, 1);

        for (int value : out) {
            System.out.print("" + value + " ");
        }
    }

    public static int[] dropNumber(int[] _p1, int _p2) {
        if (_p1.length == 0 || _p2 >= _p1.length) {
            throw new IllegalArgumentException();
        }

        int[] result = new int[_p1.length - 1];

        for (int _o1 = 0; _o1 < _p2; _o1++) {
            result[_o1] = _p1[_o1];
        }

        for (int _o1 = _p2; _o1 + 1 < _p1.length; _o1++) {
            result[_o1] = _p1[_o1 + 1];
        }

        return result;
    }
}
