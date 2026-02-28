import java.util.*;

class Java_263 {
    public static ArrayList<String> f(ArrayList<String> base, ArrayList<ArrayList<String>> delta) {
        for (int j = 0; j < delta.size(); j++) {
            for (int i = 0; i < base.size(); i++) {
                if (base.get(i).equals(delta.get(j).get(0))) {
                    assert !delta.get(j).get(1).equals(base.get(i));
                    base.set(i, delta.get(j).get(1));
                }
            }
        }
        return base;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"gloss", (String)"banana", (String)"barn", (String)"lawn"))), (new ArrayList<ArrayList<String>>(Arrays.asList()))).equals((new ArrayList<String>(Arrays.asList((String)"gloss", (String)"banana", (String)"barn", (String)"lawn")))));
    }

}
