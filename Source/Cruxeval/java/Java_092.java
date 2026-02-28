import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_092 {
    public static boolean f(String text) {
        return text.chars().allMatch(c -> c <= 127);
    }
    public static void main(String[] args) {
    assert(f(("wW의IV]HDJjhgK[dGIUlVO@Ess$coZkBqu[Ct")) == (false));
    }

}
