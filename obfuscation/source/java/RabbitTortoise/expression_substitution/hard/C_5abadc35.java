
public class C_5abadc35 {

    public static void main(String[] args) {
        int[] field = {((((1) ^ 38) ^ 38) + 0), ((((2) ^ 14) ^ 14) + 0), 3, 4, 4};
        System.out.println(rabbitTortoise(field));
    }

    public static int rabbitTortoise(int[] number_field) {
        int tortoise = number_field[((((0) ^ 25) ^ 25) + 0)];
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
