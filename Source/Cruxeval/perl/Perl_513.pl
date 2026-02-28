# 
sub f {
    my($array) = @_;
    while (grep {$_ == -1} @$array) {
        splice(@$array, -3, 1);
    }
    while (grep {$_ == 0} @$array) {
        pop(@$array);
    }
    while (grep {$_ == 1} @$array) {
        shift(@$array);
    }
    return $array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([0, 2]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
