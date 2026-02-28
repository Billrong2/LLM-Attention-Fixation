import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_640 {
    public static int f(String text) {
        int a = 0;
        if (text.substring(1).contains(String.valueOf(text.charAt(0)))) {
            a += 1;
        }
        for (int i = 0; i < text.length() - 1; i++) {
            if (text.substring(i + 1).contains(String.valueOf(text.charAt(i)))) {
                a += 1;
            }
        }
        return a;
    }
    public static void main(String[] args) {
    assert(f(("3eeeeeeoopppppppw14film3oee3")) == (18l));
    }

}
