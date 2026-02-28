import java.util.*;

class Java_053 {
    public static ArrayList<Long> f(String text) {
        Map<String, Long> occ = new HashMap<>();
        Map<Character, String> nameMap = new HashMap<>();
        nameMap.put('a', "b");
        nameMap.put('b', "c");
        nameMap.put('c', "d");
        nameMap.put('d', "e");
        nameMap.put('e', "f");

        for (char ch : text.toCharArray()) {
            String name = nameMap.getOrDefault(ch, String.valueOf(ch));
            occ.put(name, occ.getOrDefault(name, 0L) + 1);
        }

        return new ArrayList<>(occ.values());
    }
    public static void main(String[] args) {
    assert(f(("URW rNB")).equals((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)1l, (long)1l, (long)1l, (long)1l, (long)1l)))));
    }

}
