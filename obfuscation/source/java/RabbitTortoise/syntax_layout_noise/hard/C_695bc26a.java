
public class C_695bc26a {

    public static void main(String[] args) {
            if (((2 * 2) == 4)) {
                int _obf_t2_948250 = 0;
                _obf_t2_948250 += 0;
            }
        int[] field = {1, 2, 3, 4, 4};
        System.out.println(rabbitTortoise(field));
    }

    public static int rabbitTortoise(int[] number_field) {
            if (((2 * 2) == 4)) {
                int _obf_t2_766425 = 0;
                _obf_t2_766425 += 0;
            }
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
        return ((rabbit));
    }
}
