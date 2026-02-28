
public class RabbitTortoise {

    public static void main(String[] args) {
        do {
            {
                int _obf_t6_easy_708207 = 0;
                _obf_t6_easy_708207 += 0;
                    int[] field = {1, 2, 3, 4, 4};
                    System.out.println(rabbitTortoise(field));
                    
            }
        } while (false);
}

    public static int rabbitTortoise(int[] number_field) {
        do {
            {
                int _obf_t6_easy_472024 = 0;
                _obf_t6_easy_472024 += 0;
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
        } while (false);
}
}
