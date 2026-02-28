import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_761 {
    public static ArrayList<Long> f(ArrayList<Long> array) {
        ArrayList<Long> output = new ArrayList<>(array);
        for (int i = 0; i < output.size(); i += 2) {
            output.set(i, output.get(output.size() - 1 - i));
        }
        Collections.reverse(output);
        return output;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList()))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
