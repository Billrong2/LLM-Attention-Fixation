import java.util.*;

class Java_576 {
    public static ArrayList<String> f(ArrayList<Long> array, long const_val) {
        ArrayList<String> output = new ArrayList<>(Arrays.asList("x"));
        for (int i = 1; i <= array.size(); i++) {
            if (i % 2 != 0) {
                output.add(String.valueOf(array.get(i - 1) * -2));
            } else {
                output.add(String.valueOf(const_val));
            }
        }
        return output;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)2l, (long)3l))), (-1l)).equals((new ArrayList<String>(Arrays.asList((String)"x", (String)"-2", (String)"-1", (String)"-6")))));
    }

}
