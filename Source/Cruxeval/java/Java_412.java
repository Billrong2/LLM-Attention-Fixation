import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_412 {
    public static long f(long start, long end, long interval) {
        List<Long> steps = LongStream.rangeClosed(start, end).filter(num -> num % interval == 0).boxed().collect(Collectors.toList());
        if (steps.contains(1L)) {
            steps.set(steps.size() - 1, end + 1);
        }
        return steps.size();
    }
    public static void main(String[] args) {
    assert(f((3l), (10l), (1l)) == (8l));
    }

}
