# 
sub f {
    my($price, $product) = @_;
    my @inventory = ('olives', 'key', 'orange');
    if (not grep { $_ eq $product } @inventory) {
        return $price;
    } else {
        $price *= 0.85;
        @inventory = grep { $_ ne $product } @inventory;
    }
    return $price;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(8.5, "grapes"),8.5)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
