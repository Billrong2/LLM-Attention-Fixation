import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_372 {
    public static ArrayList<String> f(ArrayList<String> list_, long num) {
        ArrayList<String> temp = new ArrayList<>();
        for (String i : list_) {
            i = String.join("", Collections.nCopies((int)(num / 2), i + ","));
            temp.add(i);
        }
        return temp;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"v"))), (1l)).equals((new ArrayList<String>(Arrays.asList((String)"")))));
    }

}
