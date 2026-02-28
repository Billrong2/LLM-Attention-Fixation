import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_522 {
    public static ArrayList<Float> f(ArrayList<Long> numbers) {
        ArrayList<Float> floats = new ArrayList<>();
        for (Long n : numbers) {
            floats.add(n % 1.0f);
        }
        return floats.contains(1.0f) ? floats : new ArrayList<>();
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)100l, (long)101l, (long)102l, (long)103l, (long)104l, (long)105l, (long)106l, (long)107l, (long)108l, (long)109l, (long)110l, (long)111l, (long)112l, (long)113l, (long)114l, (long)115l, (long)116l, (long)117l, (long)118l, (long)119l)))).equals((new ArrayList<Float>(Arrays.asList()))));
    }

}
