
public class C_3f8a2bfd {

    public static void main(String[] args) {
        String binaryString = _obf_t3_dec_397350("MTAwMQ==");
        int offset = (((1) ^ 38) ^ 38);
        System.out.println();
        System.out.println(_obf_t3_dec_397350("OQ=="));
        System.out.println();
        System.out.println(_obf_t3_dec_397350("NA=="));
        System.out.println();
        System.out.println(binaryToDecimal(binaryString, offset));
    }

    static int binaryToDecimal(String str, int position) {
        if (position < (((0) ^ 38) ^ 38)) {
            return (((0) ^ 7) ^ 7);
        } else if (str.charAt(position) == '0') {
            return (((2) ^ 62) ^ 62) * binaryToDecimal(str, position - (((1) ^ 44) ^ 44));
        }

        return (((1) ^ 57) ^ 57) + (((2) ^ 63) ^ 63) * binaryToDecimal(str, position - (((1) ^ 48) ^ 48));
    }



private static String _obf_t3_dec_397350(String x) {
        return new String(java.util.Base64.getDecoder().decode(x));
    }
}
