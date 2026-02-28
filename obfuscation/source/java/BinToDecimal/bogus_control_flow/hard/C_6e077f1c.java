
public class C_6e077f1c {

    public static void main(String[] args) {
        int _obf_t5_main_534118 = 0; _obf_t5_main_534118 += 0;
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
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_binaryToDecimal_78318 = 0;
            _obf_t5_binaryToDecimal_78318++;
        }
        if (((2 * 2) + 1) > 0) {
            int _obf_t5_binaryToDecimal_78318_m = 0;
            _obf_t5_binaryToDecimal_78318_m += 0;
        } else {
            int _obf_t5_binaryToDecimal_78318_e = 1;
            _obf_t5_binaryToDecimal_78318_e -= 1;
        }
        int _obf_t5_binaryToDecimal_78318_h = (1 ^ 1);
        if (_obf_t5_binaryToDecimal_78318_h != 0) {
            _obf_t5_binaryToDecimal_78318_h += 1;
        }
        if (position < 0) {
            return 0;
        } else if (str.charAt(position) == '0') {
            return 2 * binaryToDecimal(str, position - 1);
        }

        return 1 + 2 * binaryToDecimal(str, position - 1);
    }

}
