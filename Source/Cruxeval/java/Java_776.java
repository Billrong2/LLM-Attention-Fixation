import java.util.*;

class Java_776 {
    public static HashMap<String, Long> f(HashMap<Long, Long> dictionary) {
        HashMap<String, Long> a = new HashMap<>();
        for (Map.Entry<Long, Long> entry : dictionary.entrySet()) {
            Long key = entry.getKey();
            Long value = entry.getValue();
            if (key % 2 != 0) {
                a.put("$" + key.toString(), value);
            } else {
                a.put(key.toString(), value);
            }
        }
        return a;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of()))).equals((new HashMap<String,Long>())));
    }

}
