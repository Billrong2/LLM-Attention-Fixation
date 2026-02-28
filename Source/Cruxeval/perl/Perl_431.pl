# 
sub f {
    my($n, $m) = @_;
    my @arr = (1..$n);
    for (my $i = 0; $i < $m; $i++) {
        @arr = ();
    }
    return \@arr;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(1, 3),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
