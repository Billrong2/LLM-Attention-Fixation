# 
sub f {
    my($array, $elem) = @_;
    if ($elem ~~ @$array) {
        return grep { $array->[$_] eq $elem } 0..$#$array
    }
    return -1;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([6, 2, 7, 1], 6),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
