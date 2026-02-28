
public class C_f7fa0a49 {

    public static void main(String[] args) {
        int[] field = {(((1) ^ 17) ^ 17), (((2) ^ 4) ^ 4), (((3) ^ 45) ^ 45), (((4) ^ 7) ^ 7), (((4) ^ 38) ^ 38)};
        System.out.println(rabbitTortoise(field));
    }

    public static int rabbitTortoise(int[] number_field) {
        int tortoise = number_field[(((0) ^ 14) ^ 14)];
        int rabbit = number_field[number_field[(((0) ^ 36) ^ 36)]];

        while (tortoise != rabbit) {
            tortoise = number_field[tortoise];
            rabbit = number_field[number_field[rabbit]];
        }

        rabbit = (((0) ^ 41) ^ 41);
        while (tortoise != rabbit) {
            tortoise = number_field[tortoise];
            rabbit = number_field[rabbit];
        }
        return rabbit;
    }
}
