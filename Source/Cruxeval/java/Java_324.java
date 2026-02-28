import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_324 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        ArrayList<Long> asc = new ArrayList<>(nums);
        ArrayList<Long> desc = new ArrayList<>();
        Collections.reverse(asc);
        desc.addAll(asc.subList(0, asc.size() / 2));
        asc.addAll(desc);
        asc.addAll(desc);
        return asc;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList()))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
