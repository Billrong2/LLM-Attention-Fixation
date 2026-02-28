import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_754 {
    public static ArrayList<String> f(ArrayList<String> nums) {
        int width = Integer.parseInt(nums.get(0));
        ArrayList<String> result = new ArrayList<>();
        for (int i = 1; i < nums.size(); i++) {
            String val = nums.get(i);
            String formattedVal = String.format("%" + width + "s", val).replace(' ', '0');
            result.add(formattedVal);
        }
        return result;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"1", (String)"2", (String)"2", (String)"44", (String)"0", (String)"7", (String)"20257")))).equals((new ArrayList<String>(Arrays.asList((String)"2", (String)"2", (String)"44", (String)"0", (String)"7", (String)"20257")))));
    }

}
