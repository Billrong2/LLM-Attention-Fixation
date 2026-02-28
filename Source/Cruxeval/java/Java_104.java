import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_104 {
    public static HashMap<String,Long> f(String text) {
        HashMap<String, Long> dic = new HashMap<>();
        for (int i = 0; i < text.length(); i++) {
            String chara = String.valueOf(text.charAt(i));
            dic.put(chara, dic.getOrDefault(chara, 0L) + 1);
        }
        for (String key : new HashMap<>(dic).keySet()) {
            if (dic.get(key) > 1) {
                dic.put(key, 1L);
            }
        }
        return dic;
    }
    public static void main(String[] args) {
    assert(f(("a")).equals((new HashMap<String,Long>(Map.of("a", 1l)))));
    }

}
