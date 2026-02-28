
public class C_1a4a7af1 {

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_733503 = 0;
                _obf_t2_733503 += 0;
            }
        String binaryString = "1001";
        int offset = 1;
        System.out.println();
        System.out.println("9");
        System.out.println();
        System.out.println("4");
        System.out.println();
        System.out.println(binaryToDecimal(binaryString, offset));
    }

    static int binaryToDecimal(String str, int position) {
            if (((2 * 2) == 4)) {
                int _obf_t2_341643 = 0;
                _obf_t2_341643 += 0;
            }
        if (position < 0) {
            return ((0));
        } else if (str.charAt(position) == '0') {
            return ((2 * binaryToDecimal(str, position - 1)));
        }

        return ((1 + 2 * binaryToDecimal(str, position - 1)));
    }

}
