import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_600 {
    public static ArrayList<String> f(ArrayList<Long> array) {
        ArrayList<String> just_ns = new ArrayList<>();
        for (long num : array) {
            just_ns.add("n".repeat((int) num));
        }
        
        ArrayList<String> final_output = new ArrayList<>();
        for (String wipe : just_ns) {
            final_output.add(wipe);
        }
        
        return final_output;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList()))).equals((new ArrayList<String>(Arrays.asList()))));
    }

}
