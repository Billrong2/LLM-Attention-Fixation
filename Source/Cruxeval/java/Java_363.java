import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_363 {
    public static ArrayList<Long> f(ArrayList<Long> nums) {
        Collections.sort(nums);
        int n = nums.size();
        ArrayList<Long> newNums = new ArrayList<>();
        
        newNums.add(nums.get(n/2));
        if (n % 2 == 0) {
            newNums.add(nums.get(n/2 - 1));
        }
        
        for (int i = 0; i < n/2; i++) {
            newNums.add(0, nums.get(n-i-1));
            newNums.add(nums.get(i));
        }
        
        return newNums;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<Long>(Arrays.asList((long)1l)))).equals((new ArrayList<Long>(Arrays.asList((long)1l)))));
    }

}
