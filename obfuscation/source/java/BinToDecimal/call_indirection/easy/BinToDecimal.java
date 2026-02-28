
public class BinToDecimal {

    public static void main(String[] args) {
        String binaryString = "1001";
        int offset = 1;
        System.out.println();
        System.out.println("9");
        System.out.println();
        System.out.println("4");
        System.out.println();
        System.out.println(_obf_t8_binaryToDecimal_175510(binaryString, offset));
    }

    static int binaryToDecimal(String str, int position) {
        if (position < 0) {
            return 0;
        } else if (str.charAt(position) == '0') {
            return 2 * _obf_t8_binaryToDecimal_175510(str, position - 1);
        }

        return 1 + 2 * _obf_t8_binaryToDecimal_175510(str, position - 1);
    }



private static int _obf_t8_binaryToDecimal_175510(String str, int position) {
        return binaryToDecimal(str, position);
    }
}
