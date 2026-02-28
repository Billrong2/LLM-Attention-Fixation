import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_660 {
    public static long f(long num) {
        List<Long> initial = new ArrayList<>();
        initial.add(1L);
        List<Long> total = new ArrayList<>(initial);
        for (int i = 0; i < num; i++) {
            List<Long> newTotal = new ArrayList<>();
            newTotal.add(1L);
            for (int j = 0; j < total.size()-1; j++) {
                newTotal.add(total.get(j) + total.get(j+1));
            }
            total = new ArrayList<>(newTotal);
            initial.add(total.get(total.size()-1));
        }
        
        return initial.stream().mapToLong(Long::longValue).sum();
    }
    public static void main(String[] args) {
    assert(f((3l)) == (4l));
    }

}
