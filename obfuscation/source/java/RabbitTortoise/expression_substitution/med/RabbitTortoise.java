
public class RabbitTortoise {

    public static void main(String[] args) {
        int[] field = {(((1) ^ 20) ^ 20), (((2) ^ 8) ^ 8), 3, 4, 4};
        System.out.println(rabbitTortoise(field));
    }

    public static int rabbitTortoise(int[] number_field) {
        int tortoise = number_field[(((0) ^ 13) ^ 13)];
        int rabbit = number_field[number_field[(((0) ^ 29) ^ 29)]];

        while (tortoise != rabbit) {
            tortoise = number_field[tortoise];
            rabbit = number_field[number_field[rabbit]];
        }

        rabbit = (((0) ^ 3) ^ 3);
        while (tortoise != rabbit) {
            tortoise = number_field[tortoise];
            rabbit = number_field[rabbit];
        }
        return rabbit;
    }
}
