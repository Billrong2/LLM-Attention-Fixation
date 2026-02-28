import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_144 {
    public static ArrayList<ArrayList<Long>> f(ArrayList<ArrayList<Long>> vectors) {
        for (List<Long> vec : vectors) {
            Collections.sort(vec);
        }
        return vectors;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<ArrayList<Long>>(Arrays.asList()))).equals((new ArrayList<ArrayList<Long>>(Arrays.asList()))));
    }

}
