
public class MedianOnSorted {
    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_972729 = 0;
                _obf_t6_easy_972729 += 0;
                    int[] array = {1, 2, 4, 5, 6, 16};
                    
                    System.out.println(median(array));
                    
            }
        } while (false);
}

    public static float median(int[] array) {
        do {
            {
                int _obf_t6_easy_343766 = 0;
                _obf_t6_easy_343766 += 0;
                    float b;
                    if (array.length % 2 == 1)
                    b = array[array.length / 2];
                    else
                    b = (array[array.length / 2 - 1] + array[array.length / 2]) / 2f;
                    return b;
                    
            }
        } while (false);
}
}
