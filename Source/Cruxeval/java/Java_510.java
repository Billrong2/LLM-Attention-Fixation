import java.util.*;

class Java_510 {
    public static String f(HashMap<Long,String> a, long b, String c, String d, float e) {
        String key = d;
        String num = "";
        if(a.containsKey(key)){
            num = a.get(key);
            a.remove(key);
        }
        if (b > 3){
            return c;
        } else {
            return num;
        }
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,String>(Map.of(7l, "ii5p", 1l, "o3Jwus", 3l, "lot9L", 2l, "04g", 9l, "Wjf", 8l, "5b", 0l, "te6", 5l, "flLO", 6l, "jq", 4l, "vfa0tW"))), (4l), ("Wy"), ("Wy"), (1.0f)).equals(("Wy")));
    }

}
