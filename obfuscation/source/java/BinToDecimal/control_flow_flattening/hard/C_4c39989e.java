
public class C_4c39989e {

    public static void main(String[] args) {
        int _obf_t6_main_880332 = 0; _obf_t6_main_880332 += 0;
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
        int _obf_t6_binaryToDecimal_454718 = 0; _obf_t6_binaryToDecimal_454718 += 0;
        if (position < 0) {
            return 0;
        } else if (str.charAt(position) == '0') {
            return 2 * binaryToDecimal(str, position - 1);
        }

        return 1 + 2 * binaryToDecimal(str, position - 1);
    }

}
