# 
sub f {
    my($d, $index) = @_;
    my @keys = keys %$d;
    my $length = scalar @keys;
    my $idx = $index % $length;
    my @values = values %$d;
    my $v = pop @values;
    for (1..$idx) {
        pop @values;
    }
    return $v;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({27 => 39}, 1),39)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
