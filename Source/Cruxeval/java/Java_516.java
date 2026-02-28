import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_516 {
    public static ArrayList<String> f(ArrayList<String> strings, String substr) {
        ArrayList<String> list = strings.stream()
            .filter(s -> s.startsWith(substr))
            .sorted(Comparator.comparing(String::length))
            .collect(Collectors.toCollection(ArrayList::new));
        return list;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"condor", (String)"eyes", (String)"gay", (String)"isa"))), ("d")).equals((new ArrayList<String>(Arrays.asList()))));
    }

}
