import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_251 {
    public static String f(ArrayList<ArrayList<String>> messages) {
        String phone_code = "+353";
        ArrayList<String> result = new ArrayList<>();
        for (ArrayList<String> message : messages) {
            message.addAll(Arrays.asList(phone_code.split("")));
            result.add(String.join(";", message));
        }
        return String.join(". ", result);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<ArrayList<String>>(Arrays.asList((ArrayList<String>)new ArrayList<String>(Arrays.asList((String)"Marie", (String)"Nelson", (String)"Oscar")))))).equals(("Marie;Nelson;Oscar;+;3;5;3")));
    }

}
