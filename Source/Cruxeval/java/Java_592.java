import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_592 {
    public static ArrayList<Long> f(ArrayList<Long> numbers) {
        ArrayList<Long> new_numbers = new ArrayList<>();
        for (int i = 0; i < numbers.size(); i++) {
            new_numbers.add(numbers.get(numbers.size() - 1 - i));
        }
        return new_numbers;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)11l, (long)3l)))).equals((new ArrayList<Long>(Arrays.asList((long)3l, (long)11l)))));
    }

}
