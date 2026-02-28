import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_710 {
    public static HashMap<String,ArrayList<String>> f(HashMap<String,ArrayList<String>> playlist, String liker_name, String song_index) {
        playlist.put(liker_name, playlist.getOrDefault(liker_name, new ArrayList<String>()));
        playlist.get(liker_name).add(song_index);
        return playlist;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<String,ArrayList<String>>(Map.of("aki", new ArrayList<String>(Arrays.asList((String)"1", (String)"5"))))), ("aki"), ("2")).equals((new HashMap<String,ArrayList<String>>(Map.of("aki", new ArrayList<String>(Arrays.asList((String)"1", (String)"5", (String)"2")))))));
    }

}
