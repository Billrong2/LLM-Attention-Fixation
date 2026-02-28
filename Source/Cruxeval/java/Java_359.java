import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_359 {
    public static ArrayList<String> f(ArrayList<String> lines) {
        int maxLen = lines.get(lines.size() - 1).length();
        ArrayList<String> result = new ArrayList<>();
        for (int i = 0; i < lines.size(); i++) {
            result.add(String.format("%" + maxLen + "s", lines.get(i)));
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"dZwbSR", (String)"wijHeq", (String)"qluVok", (String)"dxjxbF")))).equals((new ArrayList<String>(Arrays.asList((String)"dZwbSR", (String)"wijHeq", (String)"qluVok", (String)"dxjxbF")))));
    }

}
