import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_333 {
    public static long f(ArrayList<Long> places, ArrayList<Long> lazy) {
        Collections.sort(places);
        for (long l : lazy) {
            places.remove(l);
        }
        if (places.size() == 1) {
            return 1;
        }
        for (int i = 0; i < places.size(); i++) {
            long place = places.get(i);
            if (Collections.frequency(places, place + 1) == 0) {
                return i + 1;
            }
        }
        return places.size();
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)375l, (long)564l, (long)857l, (long)90l, (long)728l, (long)92l))), (new ArrayList<Long>(Arrays.asList((long)728l)))) == (1l));
    }

}
