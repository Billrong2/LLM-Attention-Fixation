
class ReverseArray {
    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_739347 = 0;
                _obf_t6_easy_739347 += 0;
                    int[] array = {1, 6, 4, 16, 2};
                    reverse(array);
                    
                    for (int i : array)
                    System.out.print(i + " ");
                    
            }
        } while (false);
}

    public static void reverse(int[] array) {
        do {
            {
                int _obf_t6_easy_333424 = 0;
                _obf_t6_easy_333424 += 0;
                    for (int i = 0; i <= array.length / 2 - 1; i++) {
                    int tmp = array[array.length - 1 - i];
                    array[array.length - i - 1] = array[i];
                    array[i] = tmp;
                    }
                    
            }
        } while (false);
}
}
