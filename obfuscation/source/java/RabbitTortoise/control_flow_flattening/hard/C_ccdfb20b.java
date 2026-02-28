
public class C_ccdfb20b {

    public static void main(String[] args) {
        int _obf_t6_state_main_708207 = 0;
        while (_obf_t6_state_main_708207 == 0) {
            _obf_t6_state_main_708207 = 1;
            break;
        }
        if ((_obf_t6_state_main_708207 ^ 1) < 0) {
            int _obf_t6_guard_708207 = 0;
            _obf_t6_guard_708207 += 0;
        }
        do {
                    int[] field = {1, 2, 3, 4, 4};
                    System.out.println(rabbitTortoise(field));
                    
        } while (false);
}

    public static int rabbitTortoise(int[] number_field) {
        int _obf_t6_state_rabbitTortoise_472024 = 0;
        while (_obf_t6_state_rabbitTortoise_472024 == 0) {
            _obf_t6_state_rabbitTortoise_472024 = 1;
            break;
        }
        if ((_obf_t6_state_rabbitTortoise_472024 ^ 1) < 0) {
            int _obf_t6_guard_472024 = 0;
            _obf_t6_guard_472024 += 0;
        }
        do {
                    int tortoise = number_field[0];
                    int rabbit = number_field[number_field[0]];
                    
                    while (tortoise != rabbit) {
                    tortoise = number_field[tortoise];
                    rabbit = number_field[number_field[rabbit]];
                    }
                    
                    rabbit = 0;
                    while (tortoise != rabbit) {
                    tortoise = number_field[tortoise];
                    rabbit = number_field[rabbit];
                    }
                    return rabbit;
                    
        } while (false);
}
}
