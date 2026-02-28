
public class MedianOnSorted {
    public static void main(String[] args) {
        int _obf_t6_state_main_972729 = 0;
        while (_obf_t6_state_main_972729 == 0) {
            _obf_t6_state_main_972729 = 1;
            break;
        }
        do {
                    int[] array = {1, 2, 4, 5, 6, 16};
                    
                    System.out.println(median(array));
                    
        } while (false);
}

    public static float median(int[] array) {
        int _obf_t6_median_299966 = 0; _obf_t6_median_299966 += 0;
        float b;
        if (array.length % 2 == 1)
            b = array[array.length / 2];
        else
            b = (array[array.length / 2 - 1] + array[array.length / 2]) / 2f;
        return b;
    }
}
