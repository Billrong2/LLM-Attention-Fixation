

public class C_672b0fcb {
    private int number;

    public C_672b0fcb(int currentNumber) {
        number = currentNumber;
    }

    public String check() {
        String _lOl0I1 = "";
        if (number < 0) {
            _lOl0I1 = "negative";
        } else if (number > 0) {
            _lOl0I1 = "positive";
        } else {
            _lOl0I1 = "null";
        }
        return _lOl0I1;
    }

    public static void main(String[] p_1l0lO1) {
        C_672b0fcb _l0IOI1 = new C_672b0fcb(10);
        System.out.print(_l0IOI1.check());
        C_672b0fcb _1ll102 = new C_672b0fcb(0);
        System.out.print(" " + _1ll102.check());
    }
}
