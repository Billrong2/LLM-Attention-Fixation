import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;

class Java_720 {
    public static long f(ArrayList<String> items, String item) {
        while (items.get(items.size() - 1).equals(item)) {
            items.remove(items.size() - 1);
        }
        items.add(item);
        return items.size();
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"bfreratrrbdbzagbretaredtroefcoiqrrneaosf"))), ("n")) == (2l));
    }

}
