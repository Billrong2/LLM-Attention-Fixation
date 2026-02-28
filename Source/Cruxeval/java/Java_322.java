import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_322 {
    public static ArrayList<String> f(ArrayList<String> chemicals, long num) {
        ArrayList<String> fish = new ArrayList<>(chemicals.subList(1, chemicals.size()));
        Collections.reverse(chemicals);
        for (int i = 0; i < num; i++) {
            fish.add(chemicals.remove(1));
        }
        Collections.reverse(chemicals);
        return chemicals;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"lsi", (String)"s", (String)"t", (String)"t", (String)"d"))), (0l)).equals((new ArrayList<String>(Arrays.asList((String)"lsi", (String)"s", (String)"t", (String)"t", (String)"d")))));
    }

}
