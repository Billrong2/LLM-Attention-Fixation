import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_663 {
    public static ArrayList<Long> f(ArrayList<Long> container, long cron) {
        if (!container.contains(cron)) return container;
        ArrayList<Long> pref = new ArrayList<>(container.subList(0, container.indexOf(cron)));
        ArrayList<Long> suff = new ArrayList<>(container.subList(container.indexOf(cron) + 1, container.size()));
        pref.addAll(suff);
        return pref;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList())), (2l)).equals((new ArrayList<Long>(Arrays.asList()))));
    }

}
