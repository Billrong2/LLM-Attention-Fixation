import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_102 {
    public static ArrayList<Long> f(ArrayList<String> names, ArrayList<String> winners) {
        ArrayList<Long> ls = new ArrayList<>();
        for (String name : names) {
            int index = names.indexOf(name);
            if (winners.contains(name)) {
                ls.add((long)index);
            }
        }
        Collections.sort(ls, Collections.reverseOrder());
        return ls;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"e", (String)"f", (String)"j", (String)"x", (String)"r", (String)"k"))), (new ArrayList<String>(Arrays.asList((String)"a", (String)"v", (String)"2", (String)"im", (String)"nb", (String)"vj", (String)"z")))).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
