import java.util.*;

class Java_011 {
    public static HashMap<String,ArrayList<String>> f(HashMap<String,ArrayList<String>> a, HashMap<String,String> b) {
        for (Map.Entry<String, String> entry : b.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();
            if (!a.containsKey(key)) {
                a.put(key, new ArrayList<String>(Arrays.asList(value)));
            } else {
                a.get(key).add(value);
            }
        }
        return a;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,ArrayList<String>>()), (new HashMap<String,String>(Map.of("foo", "bar")))).equals((new HashMap<String,ArrayList<String>>(Map.of("foo", new ArrayList<String>(Arrays.asList((String)"bar")))))));
    }

}
