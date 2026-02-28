import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_477 {
    public static Pair<String, String> f(String text) {
        int index = text.lastIndexOf('|');
        String topic = text.substring(0, index);
        String problem = text.substring(index + 1);
        if (problem.equals("r")) {
            problem = topic.replace('u', 'p');
        }
        return Pair.with(topic, problem);
    }
    public static void main(String[] args) {
    assert(f(("|xduaisf")).equals((Pair.with("", "xduaisf"))));
    }

}
