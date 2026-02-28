import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_150 {
    public static ArrayList<Long> f(ArrayList<Long> numbers, long index) {
        if(index > numbers.size())
            return numbers;
        ArrayList<Long> sublist = new ArrayList<>(numbers.subList((int)index, numbers.size()));
        Collections.reverse(sublist);
        for(int i = 0; i < sublist.size(); i++)
            numbers.add((int)index, sublist.get(i));
        return new ArrayList<>(numbers.subList(0, (int)index + sublist.size()));
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)-2l, (long)4l, (long)-4l))), (0l)).equals((new ArrayList<Long>(Arrays.asList((long)-2l, (long)4l, (long)-4l)))));
    }

}
