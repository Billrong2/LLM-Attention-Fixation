import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_029 {
    public static String f(String text) {
        List<Character> nums = text.chars()
                .mapToObj(c -> (char) c)
                .filter(Character::isDigit)
                .collect(Collectors.toList());
        
        assert nums.size() > 0;

        StringBuilder sb = new StringBuilder();
        for (char num : nums) {
            sb.append(num);
        }
        
        return sb.toString();
    }
    public static void main(String[] args) {
    assert(f(("-123   	+314")).equals(("123314")));
    }

}
