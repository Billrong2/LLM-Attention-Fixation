import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_059 {
    public static String f(String s) {
        List<Character> a = s.chars()
                            .mapToObj(c -> (char) c)
                            .filter(ch -> ch != ' ')
                            .collect(Collectors.toList());
        
        List<Character> b = new ArrayList<>(a);
        
        for (int i = a.size() - 1; i >= 0; i--) {
            char c = a.get(i);
            if (c == ' ') {
                b.remove(b.size() - 1);
            } else {
                break;
            }
        }
        
        StringBuilder sb = new StringBuilder();
        for (char ch : b) {
            sb.append(ch);
        }
        
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("hi ")).equals(("hi")));
    }

}
