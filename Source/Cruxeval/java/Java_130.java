import java.util.*;

class Java_130 {
    public static String f(HashMap<String,Long> m) {
        ArrayList<Map.Entry<String, Long>> items = new ArrayList<>(m.entrySet());
        for (int i = items.size() - 2; i >= 0; i--) {
            Map.Entry<String, Long> tmp = items.get(i);
            items.set(i, items.get(i+1));
            items.set(i+1, tmp);
        }
        return String.format("%s=%s", m.keySet().toArray());
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("l", 4l, "h", 6l, "o", 9l)))).equals(("h=l")));
    }

}
