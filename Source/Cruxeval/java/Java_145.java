import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_145 {
    public static float f(float price, String product) {
        List<String> inventory = new ArrayList<>(Arrays.asList("olives", "key", "orange"));
        if (!inventory.contains(product)) {
            return price;
        } else {
            price *= 0.85f;
            inventory.remove(product);
        }
        return price;
    }
    public static void main(String[] args) {
    assert(f((8.5f), ("grapes")) == (8.5f));
    }

}
