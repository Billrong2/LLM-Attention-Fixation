
public class RabbitTortoise {

    public static void main(String[] args) {
        int _obf_t1_main_856081 = 0; _obf_t1_main_856081 += 0;
        int[] field = {1, 2, 3, 4, 4};
        System.out.println(rabbitTortoise(field));
    }

    public static int rabbitTortoise(int[] number_field) {
        int v1 = number_field[0];
        int v2 = number_field[number_field[0]];

        while (v1 != v2) {
            v1 = number_field[v1];
            v2 = number_field[number_field[v2]];
        }

        v2 = 0;
        while (v1 != v2) {
            v1 = number_field[v1];
            v2 = number_field[v2];
        }
        return v2;
    }
}
