import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_288 {
    public static ArrayList<Pair<Long, Long>> f(HashMap<Long,Long> d) {
        List<Map.Entry<Long, Long>> sortedPairs = new ArrayList<>(d.entrySet());
        sortedPairs.sort((entry1, entry2) -> Long.compare(
                String.valueOf(entry1.getKey()).length() + String.valueOf(entry1.getValue()).length(),
                String.valueOf(entry2.getKey()).length() + String.valueOf(entry2.getValue()).length()));

        ArrayList<Pair<Long, Long>> result = new ArrayList<>();
        for (Map.Entry<Long, Long> entry : sortedPairs) {
            if (entry.getKey() < entry.getValue()) {
                result.add(new Pair<>(entry.getKey(), entry.getValue()));
            }
        }
        
        return result;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of(55l, 4l, 4l, 555l, 1l, 3l, 99l, 21l, 499l, 4l, 71l, 7l, 12l, 6l)))).equals((new ArrayList<Pair<Long, Long>>(Arrays.asList((Pair<Long, Long>)Pair.with(1l, 3l), (Pair<Long, Long>)Pair.with(4l, 555l))))));
    }

}
