import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_262 {
    public static String f(ArrayList<Long> nums) {
        int count = nums.size();
        Map<Integer, String> score = new HashMap<>();
        score.put(0, "F");
        score.put(1, "E");
        score.put(2, "D");
        score.put(3, "C");
        score.put(4, "B");
        score.put(5, "A");
        score.put(6, "");
        
        List<String> result = new ArrayList<>();
        for (int i = 0; i < count; i++) {
            result.add(score.get(nums.get(i).intValue()));
        }
        
        return String.join("", result);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)4l, (long)5l)))).equals(("BA")));
    }

}
