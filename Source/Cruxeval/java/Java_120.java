import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_120 {
    public static HashMap<String,ArrayList<String>> f(HashMap<String,String> countries) {
        HashMap<String,ArrayList<String>> language_country = new HashMap<>();
        for (Map.Entry<String, String> entry : countries.entrySet()) {
            String country = entry.getKey();
            String language = entry.getValue();
            if (!language_country.containsKey(language)) {
                language_country.put(language, new ArrayList<>());
            }
            language_country.get(language).add(country);
        }
        return language_country;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,String>())).equals((new HashMap<String,ArrayList<String>>())));
    }

}
