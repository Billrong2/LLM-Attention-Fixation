import java.util.*;

class Java_503 {
    public static ArrayList<Long> f(HashMap<Long,Long> d) {
        ArrayList<Long> result = new ArrayList<>(Collections.nCopies(d.size(), null));
        int a = 0, b = 0;
        while (!d.isEmpty()) {
            List<Long> keys = new ArrayList<>(d.keySet());
            Long key = keys.get(a == b ? 0 : 1);
            result.set(a, key);
            d.remove(key);
            a = b;
            b = (b + 1) % result.size();
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of()))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
