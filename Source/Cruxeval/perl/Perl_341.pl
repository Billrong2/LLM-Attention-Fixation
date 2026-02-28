# 
sub f {
    my($cart) = @_;
    while (scalar(keys %$cart) > 5) {
        my @keys = keys %$cart;
        delete $cart->{$keys[-1]};
    }
    return $cart;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
