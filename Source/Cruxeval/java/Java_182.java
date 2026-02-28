import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_182 {
    public static ArrayList<Pair<String, Long>> f(HashMap<String,Long> dic) {
        List<Map.Entry<String, Long>> list = new ArrayList<>(dic.entrySet());
        list.sort(Comparator.comparing(Map.Entry::getKey));
        
        ArrayList<Pair<String, Long>> result = list.stream()
                .map(entry -> new Pair<>(entry.getKey(), entry.getValue()))
                .collect(Collectors.toCollection(ArrayList::new));
        
        return result;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,Long>(Map.of("b", 1l, "a", 2l)))).equals((new ArrayList<Pair<String, Long>>(Arrays.asList((Pair<String, Long>)Pair.with("a", 2l), (Pair<String, Long>)Pair.with("b", 1l))))));
    }

}
