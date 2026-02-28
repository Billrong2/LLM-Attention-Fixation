import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_225 {
    public static boolean f(String text) {
        for(char c : text.toCharArray()){
            if(!Character.isLowerCase(c)) return false;
        }
        return true;
    }
    public static void main(String[] args) {
    assert(f(("54882")) == (false));
    }

}
