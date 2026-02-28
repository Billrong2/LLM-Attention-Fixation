sub f {
    my($s, $n) = @_;
    my @ls = split / /, $s;
    my @out = ();
    while (@ls >= $n) {
        push @out, @ls[ -$n .. -1 ];
        splice @ls, -$n;
    }
    return [ @ls, join '_', @out ];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("one two three four five", 3),["one", "two", "three_four_five"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
