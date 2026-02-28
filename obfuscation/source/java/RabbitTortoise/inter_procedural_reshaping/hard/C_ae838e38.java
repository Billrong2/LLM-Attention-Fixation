
public class C_ae838e38 {

    public static void main(String[] args) {
        _obf_t7_hook_main_139362();
        int[] field = {1, 2, 3, 4, 4};
        System.out.println(rabbitTortoise(field));
    }

    public static int rabbitTortoise(int[] number_field) {
        _obf_t7_hook_rabbitTortoise_861415();
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
    }


private static void _obf_t7_hook_rabbitTortoise_861415() {
        int _obf_t7_861415 = 0;
        _obf_t7_861415 += 0;
    }

    private static void _obf_t7_hook_main_139362() {
        int _obf_t7_139362 = 0;
        _obf_t7_139362 += 0;
    }
}
