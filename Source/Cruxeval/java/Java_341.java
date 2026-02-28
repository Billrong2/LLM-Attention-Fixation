import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_341 {
    public static HashMap<Long,Long> f(HashMap<Long,Long> cart) {
        while (cart.size() > 5) {
            cart.remove(cart.keySet().iterator().next());
        }
        return cart;
    }
    public static void main(String[] args) {
    assert(f((new HashMap<Long,Long>(Map.of()))).equals((new HashMap<Long,Long>(Map.of()))));
    }

}
