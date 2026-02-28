import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_166 {
    public static HashMap<String,HashMap<String,String>> f(HashMap<String,HashMap<String,String>> graph) {
        HashMap<String, HashMap<String, String>> newGraph = new HashMap<>();
        for (Map.Entry<String, HashMap<String, String>> entry : graph.entrySet()) {
            String key = entry.getKey();
            newGraph.put(key, new HashMap<>());
            for (String subkey : entry.getValue().keySet()) {
                newGraph.get(key).put(subkey, "");
            }
        }
        return newGraph;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,HashMap<String,String>>())).equals((new HashMap<String,HashMap<String,String>>())));
    }

}
