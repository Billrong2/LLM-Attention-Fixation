import java.util.*;

class Java_050 {
    public static ArrayList<Long> f(ArrayList<String> lst) {
        lst.clear();
        return new ArrayList<Long>(Collections.nCopies(lst.size() + 1, 1L));
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"a", (String)"c", (String)"v")))).equals((new ArrayList<Long>(Arrays.asList((long)1l)))));
    }

}
