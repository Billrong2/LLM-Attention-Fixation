import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_418 {
    public static String f(String s, String p) {
        String[] arr = s.split(p, 2);
        String partOne = arr[0];
        String partTwo = p;
        String partThree = arr.length > 1 ? arr[1] : "";
        
        if (partOne.length() >= 2 && partTwo.length() <= 2 && partThree.length() >= 2) {
            return new StringBuilder(partOne).reverse().toString() + partTwo + new StringBuilder(partThree).reverse().toString() + "#";
        }
        return partOne + partTwo + partThree;
    }
    public static void main(String[] args) {
    assert(f(("qqqqq"), ("qqq")).equals(("qqqqq")));
    }

}
