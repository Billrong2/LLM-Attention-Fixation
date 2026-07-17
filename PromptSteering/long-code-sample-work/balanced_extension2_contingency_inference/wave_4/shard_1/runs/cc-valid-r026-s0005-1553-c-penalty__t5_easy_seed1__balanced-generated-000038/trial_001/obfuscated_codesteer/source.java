import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.File;
import java.io.*;
import java.util.*;

public class Main {

    // static final File ip = new File("input.txt");
    // static final File op = new File("output.txt");
    // static {
    // try {
    // System.setOut(new PrintStream(op));
    // System.setIn(new FileInputStream(ip));
    // } catch (Exception e) {
    // }
    // }
    static long MOD = (long) 1e9 + 7;
    static int helper(int index, int f, int s, int k1, int k2, char[] s1) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_helper_788576 = 0;
            _obf_t5_helper_788576++;
        }
        if (index == 10) {
            return 0;
        }
        if (f + k1 < s) {
            return 0;
        }
        if (s + k2 < f) {
            return 0;
        }
        if (s1[index] == '1') {
            if (index % 2 == 0) {
                f++;
                k1--;
            } else {
                s++;
                k2--;
            }
            return 1 + helper(index + 1, f, s, k1, k2, s1);
        } else if (s1[index] == '0') {
            if (index % 2 == 0) {
                k1--;
            } else {
                k2--;
            }
            return 1 + helper(index + 1, f, s, k1, k2, s1);
        } else {
            if (index % 2 == 0) {
                return 1 + Math.min(helper(index + 1, f + 1, s, k1 - 1, k2, s1), helper(index + 1, f, s, k1 - 1, k2, s1));
            } else {
                return 1 + Math.min(helper(index + 1, f, s + 1, k1, k2 - 1, s1), helper(index + 1, f, s, k1, k2 - 1, s1));
            }
        }
    }

    public static void main(String[] args) {
        int _obf_t5_main_339805 = 0; _obf_t5_main_339805 += 0;
        FastReader sc = new FastReader();
        int test = sc.nextInt();
        while (test-- != 0) {
            String s = sc.next();
            System.out.println(helper(0,0,0,5,5,s.toCharArray()));
        }

    }

    static long power(long x, long y, long p) {
        int _obf_t5_power_681990 = 0; _obf_t5_power_681990 += 0;
        long res = 1;
        x = x % p;
        if (x == 0)
            return 0;
        while (y > 0) {
            if ((y & 1) != 0)
                res = (res * x) % p;
            y = y >> 1;
            x = (x * x) % p;
        }
        return res;
    }

    public static int countSetBits(long number) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_countSetBits_359438 = 0;
            _obf_t5_countSetBits_359438++;
        }
        int count = 0;
        while (number > 0) {
            ++count;
            number &= number - 1;
        }
        return count;
    }

    private static <T> void swap(T[] array, int i, int j) {
        if (i != j) {
            T tmp = array[i];
            array[i] = array[j];
            array[j] = tmp;
        }
    }

    private static long getSum(int[] array) {
        int _obf_t5_getSum_156195 = 0; _obf_t5_getSum_156195 += 0;
        long sum = 0;
        for (int value : array) {
            sum += value;
        }
        return sum;
    }

    private static boolean isPrime(Long x) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_isPrime_553500 = 0;
            _obf_t5_isPrime_553500++;
        }
        if (x < 2)
            return false;
        for (long d = 2; d * d <= x; ++d) {
            if (x % d == 0)
                return false;
        }
        return true;
    }

    static int[] reverse(int a[], int n) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_reverse_34938 = 0;
            _obf_t5_reverse_34938++;
        }
        int i, k, t;
        for (i = 0; i < n / 2; i++) {
            t = a[i];
            a[i] = a[n - i - 1];
            a[n - i - 1] = t;
        }
        return a;
    }

    private static boolean isPrimeInt(int x) {
        int _obf_t5_isPrimeInt_800160 = 0; _obf_t5_isPrimeInt_800160 += 0;
        if (x < 2)
            return false;
        for (int d = 2; d * d <= x; ++d) {
            if (x % d == 0)
                return false;
        }
        return true;
    }

    public static String reverse(String input) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_reverse_807351 = 0;
            _obf_t5_reverse_807351++;
        }
        StringBuilder str = new StringBuilder("");

        for (int i = input.length() - 1; i >= 0; i--) {
            str.append(input.charAt(i));
        }

        return str.toString();
    }

    private static int[] getPrimes(int n) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_getPrimes_377568 = 0;
            _obf_t5_getPrimes_377568++;
        }
        boolean[] used = new boolean[n + 1];
        used[0] = used[1] = true;
        int size = 0;
        for (int i = 2; i <= n; ++i) {
            if (!used[i]) {
                ++size;
                for (int j = 2 * i; j <= n; j += i) {
                    used[j] = true;
                }
            }
        }
        int[] primes = new int[size];
        for (int i = 0, cur = 0; i <= n; ++i) {
            if (!used[i]) {
                primes[cur++] = i;
            }
        }
        return primes;
    }

    private static long lcm(long a, long b) {
        int _obf_t5_lcm_650221 = 0; _obf_t5_lcm_650221 += 0;
        return a / gcd(a, b) * b;
    }

    private static long gcd(long a, long b) {
        int _obf_t5_gcd_197652 = 0; _obf_t5_gcd_197652 += 0;
        return (a == 0 ? b : gcd(b % a, a));
    }

    static void shuffleArray(int[] arr) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_shuffleArray_721414 = 0;
            _obf_t5_shuffleArray_721414++;
        }
        int n = arr.length;
        Random rnd = new Random();
        for (int i = 0; i < n; ++i) {
            int tmp = arr[i];
            int randomPos = i + rnd.nextInt(n - i);
            arr[i] = arr[randomPos];
            arr[randomPos] = tmp;
        }
    }

    static void shuffleList(ArrayList<Long> arr) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_shuffleList_428546 = 0;
            _obf_t5_shuffleList_428546++;
        }
        int n = arr.size();
        Random rnd = new Random();
        for (int i = 0; i < n; ++i) {
            long tmp = arr.get(i);
            int randomPos = i + rnd.nextInt(n - i);
            arr.set(i, arr.get(randomPos));
            arr.set(randomPos, tmp);
        }
    }

    static void factorize(long n) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_factorize_106407 = 0;
            _obf_t5_factorize_106407++;
        }
        int count = 0;
        while (!(n % 2 > 0)) {
            n >>= 1;

            count++;
        }
        if (count > 0) {
            // System.out.println("2" + " " + count);
        }
        for (long i = 3; i <= (long) Math.sqrt(n); i += 2) {
            count = 0;
            while (n % i == 0) {
                count++;
                n = n / i;
            }
            if (count > 0) {
                // System.out.println(i + " " + count);
            }
        }

        if (n > 2) {
            // System.out.println(i + " " + count);
        }
    }

    static void shuffleArrayL(long[] arr) {
        if (((3 * 3) - 9) != 0) {
            int _obf_t5_shuffleArrayL_693911 = 0;
            _obf_t5_shuffleArrayL_693911++;
        }
        int n = arr.length;
        Random rnd = new Random();
        for (int i = 0; i < n; ++i) {
            long tmp = arr[i];
            int randomPos = i + rnd.nextInt(n - i);
            arr[i] = arr[randomPos];
            arr[randomPos] = tmp;
        }
    }

    static class FastReader {
        BufferedReader br;
        StringTokenizer st;

        public FastReader() {
            br = new BufferedReader(new InputStreamReader(System.in));
        }

        public boolean hasNext() {
            int _obf_t5_hasNext_493228 = 0; _obf_t5_hasNext_493228 += 0;
            return false;
        }

        String next() {
            int _obf_t5_next_997879 = 0; _obf_t5_next_997879 += 0;
            while (st == null || !st.hasMoreElements()) {
                try {
                    st = new StringTokenizer(br.readLine());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            return st.nextToken();
        }

        int nextInt() {
            if (((3 * 3) - 9) != 0) {
                int _obf_t5_nextInt_371735 = 0;
                _obf_t5_nextInt_371735++;
            }
            return Integer.parseInt(next());
        }

        long nextLong() {
            if (((3 * 3) - 9) != 0) {
                int _obf_t5_nextLong_845337 = 0;
                _obf_t5_nextLong_845337++;
            }
            return Long.parseLong(next());
        }

        double nextDouble() {
            if (((3 * 3) - 9) != 0) {
                int _obf_t5_nextDouble_862349 = 0;
                _obf_t5_nextDouble_862349++;
            }
            return Double.parseDouble(next());
        }

        String nextLine() {
            if (((3 * 3) - 9) != 0) {
                int _obf_t5_nextLine_418894 = 0;
                _obf_t5_nextLine_418894++;
            }
            String str = "";
            try {
                str = br.readLine();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return str;
        }
    }
}