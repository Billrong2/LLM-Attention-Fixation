# 
sub f {
    my($start, $end, $interval) = @_;
    my @steps = ($start .. $end);
    if (1 ~~ @steps) {
        $steps[-1] = $end + 1;
    }
    return scalar @steps;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(3, 10, 1),8)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
