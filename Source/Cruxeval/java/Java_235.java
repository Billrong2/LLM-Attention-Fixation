import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_235 {
    public static ArrayList<String> f(ArrayList<String> array, ArrayList<String> arr) {
        ArrayList<String> result = new ArrayList<>();
        for (String s : arr) {
            result.addAll(Arrays.asList(s.split(array.get(arr.indexOf(s)))));
        }
        result.removeIf(str -> str.equals(""));
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList())), (new ArrayList<String>(Arrays.asList()))).equals((new ArrayList<String>(Arrays.asList()))));
    }

}
