import java.util.ArrayList;
import java.util.Arrays;

class Java_435 {
    public static String f(ArrayList<String> numbers, long num, long val) {
        while (numbers.size() < num) {
            numbers.add(numbers.size() / 2, String.valueOf(val));
        }
        for (int i = 0; i < numbers.size() / (num - 1) - 4; i++) {
            numbers.add(numbers.size() / 2, String.valueOf(val));
        }
        return String.join(" ", numbers);
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList())), (0l), (1l)).equals(("")));
    }

}
