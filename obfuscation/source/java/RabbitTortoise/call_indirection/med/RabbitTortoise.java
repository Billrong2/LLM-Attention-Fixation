
public class RabbitTortoise {

    public static void main(String[] args) {
        int[] field = {1, 2, 3, 4, 4};
        System.out.println(_obf_t8_rabbitTortoise_908192(field));
    }

    public static int rabbitTortoise(int[] number_field) {
        int _obf_t8_rabbitTortoise_158070 = 0; _obf_t8_rabbitTortoise_158070 += 0;
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


private static int _obf_t8_rabbitTortoise_908192(int[] number_field) {
        int _obf_sel = 2;
        switch (_obf_sel) {
            case 2: return rabbitTortoise(number_field);
            default: return rabbitTortoise(number_field);
        }
    }
}
