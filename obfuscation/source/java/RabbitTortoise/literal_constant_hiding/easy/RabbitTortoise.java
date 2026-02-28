
public class RabbitTortoise {

    public static void main(String[] args) {
        int _obf_t3_main_476976 = 0; _obf_t3_main_476976 += 0;
        int[] field = {1, 2, 3, 4, 4};
        System.out.println(rabbitTortoise(field));
    }

    public static int rabbitTortoise(int[] number_field) {
        int _obf_t3_rabbitTortoise_36252 = 0; _obf_t3_rabbitTortoise_36252 += 0;
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
}
