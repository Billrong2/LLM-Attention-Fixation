import java.util.*;
import java.util.stream.*;

class Java_108 {
    public static long f(Object var) {
        long amount = 0;

        if (var instanceof List) {
            amount = ((List<?>)var).size();
        } else if (var instanceof Map) {
            amount = ((Map<?, ?>)var).size();
        }

        return amount > 0 ? amount : 0;
    }
    public static void main(String[] args) {
    assert(f((1l)) == (0l));
    }

}
