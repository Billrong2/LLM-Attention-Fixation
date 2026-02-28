
public class BinToDecimal {

    public static void main(String[] args) {
        int _obf_t4_main_423236 = 0; _obf_t4_main_423236 += 0;
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
        if (position < 0) {
            return ((0) + 0);
        } else if (str.charAt(position) == '0') {
            return 2 * binaryToDecimal(str, position - 1);
        }

        return ((1) + 0) + 2 * binaryToDecimal(str, position - 1);
    }

}
