import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_563 {
    public static long f(String text1, String text2) {
        int[] nums = new int[text2.length()];
        for (int i = 0; i < text2.length(); i++) {
            nums[i] = text1.length() - text1.replace(String.valueOf(text2.charAt(i)), "").length();
        }
        return Arrays.stream(nums).sum();
    }
    public static void main(String[] args) {
    assert(f(("jivespdcxc"), ("sx")) == (2l));
    }

}
