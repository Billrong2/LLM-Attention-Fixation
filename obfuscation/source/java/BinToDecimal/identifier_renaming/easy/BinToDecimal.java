
public class BinToDecimal {

    public static void main(String[] args) {
        String v1 = "1001";
        int v2 = 1;
        System.out.println();
        System.out.println("9");
        System.out.println();
        System.out.println("4");
        System.out.println();
        System.out.println(binaryToDecimal(v1, v2));
    }

    static int binaryToDecimal(String str, int position) {
        int _obf_t1_binaryToDecimal_914702 = 0; _obf_t1_binaryToDecimal_914702 += 0;
        if (position < 0) {
            return 0;
        } else if (str.charAt(position) == '0') {
            return 2 * binaryToDecimal(str, position - 1);
        }

        return 1 + 2 * binaryToDecimal(str, position - 1);
    }

}
