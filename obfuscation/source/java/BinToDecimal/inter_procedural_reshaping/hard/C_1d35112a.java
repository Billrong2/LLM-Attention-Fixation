
public class C_1d35112a {

    public static void main(String[] args) {
        _obf_t7_hook_main_333770();
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
        _obf_t7_hook_binaryToDecimal_455918();
        if (position < 0) {
            return 0;
        } else if (str.charAt(position) == '0') {
            return 2 * binaryToDecimal(str, position - 1);
        }

        return 1 + 2 * binaryToDecimal(str, position - 1);
    }



private static void _obf_t7_hook_binaryToDecimal_455918() {
        int _obf_t7_455918 = 0;
        _obf_t7_455918 += 0;
    }

    private static void _obf_t7_hook_main_333770() {
        int _obf_t7_333770 = 0;
        _obf_t7_333770 += 0;
    }
}
