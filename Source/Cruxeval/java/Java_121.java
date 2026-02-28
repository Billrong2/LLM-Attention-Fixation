import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_121 {
    public static String f(String s) {
        String nums = s.replaceAll("\\D", "");
        if (nums.isEmpty()) {
            return "none";
        }
        String[] numArr = nums.split(",");
        int maxNum = Arrays.stream(numArr)
                .map(Integer::parseInt)
                .max(Integer::compare)
                .get();
        return Integer.toString(maxNum);
    }
    public static void main(String[] args) {
    assert(f(("01,001")).equals(("1001")));
    }

}
