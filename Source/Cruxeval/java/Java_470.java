import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_470 {
    public static ArrayList<String> f(long number) {
        HashMap<String, Integer> transl = new HashMap<>();
        transl.put("A", 1);
        transl.put("B", 2);
        transl.put("C", 3);
        transl.put("D", 4);
        transl.put("E", 5);
        
        ArrayList<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : transl.entrySet()) {
            if (entry.getValue() % number == 0) {
                result.add(entry.getKey());
            }
        }
        
        return result;
    }
    public static void main(String[] args) {
    assert(f((2l)).equals((new ArrayList<String>(Arrays.asList((String)"B", (String)"D")))));
    }

}
