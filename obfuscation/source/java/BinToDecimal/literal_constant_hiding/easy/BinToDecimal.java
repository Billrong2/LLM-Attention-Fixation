
public class BinToDecimal {

    public static void main(String[] args) {
        String binaryString = ("" + "1001");
        int offset = 1;
        System.out.println();
        System.out.println(("" + "9"));
        System.out.println();
        System.out.println(("" + "4"));
        System.out.println();
        System.out.println(binaryToDecimal(binaryString, offset));
    }

    static int binaryToDecimal(String str, int position) {
        int _obf_t3_binaryToDecimal_186234 = 0; _obf_t3_binaryToDecimal_186234 += 0;
        if (position < 0) {
            return 0;
        } else if (str.charAt(position) == '0') {
            return 2 * binaryToDecimal(str, position - 1);
        }

        return 1 + 2 * binaryToDecimal(str, position - 1);
    }

}
