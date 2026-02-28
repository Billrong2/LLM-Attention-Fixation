
public class BinToDecimal {

    public static void main(String[] args) {
        String binaryString = _obf_t3_dec_397350("MTAwMQ==");
        int offset = 1;
        System.out.println();
        System.out.println(_obf_t3_dec_397350("OQ=="));
        System.out.println();
        System.out.println(_obf_t3_dec_397350("NA=="));
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



private static String _obf_t3_dec_397350(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
