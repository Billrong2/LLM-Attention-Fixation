class C_85ed2a30 {

    public static void main(String[] args) {
        int _obf_t6_state_main_995898 = ((2 * 3) - 6);
        switch (_obf_t6_state_main_995898) {
            case 0: {
                _obf_t6_state_main_995898 = 1;
                break;
            }
            case 7: {
                _obf_t6_state_main_995898 = 1;
                break;
            }
            default: {
                _obf_t6_state_main_995898 = 1;
                break;
            }
        }
        do {
                    int x = 1;
                    int y = 1;
                    System.out.println("");
                    System.out.println(5);
                    System.out.println("");
                    System.out.println(6);
                    System.out.println("");
                    System.out.println(ackermann(x, y));
                    
        } while (false);
        if (_obf_t6_state_main_995898 == 7) {
            int _obf_t6_guard_995898 = 0;
            _obf_t6_guard_995898 += 0;
        }
}

    public static int ackermann(int n, int m) {
        int _obf_t6_state_ackermann_703598 = ((2 * 3) - 6);
        switch (_obf_t6_state_ackermann_703598) {
            case 0: {
                _obf_t6_state_ackermann_703598 = 1;
                break;
            }
            case 7: {
                _obf_t6_state_ackermann_703598 = 1;
                break;
            }
            default: {
                _obf_t6_state_ackermann_703598 = 1;
                break;
            }
        }
        do {
                    if (n == 0) {
                    return m + 1;
                    } else if (m == 0) {
                    return ackermann(n - 1, 1);
                    }
                    
                    return ackermann(n - 1, ackermann(n, m - 1));
                    
        } while (false);
}

}


