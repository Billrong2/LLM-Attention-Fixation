# 
sub f {
    my($array, $L) = @_;
    if ($L <= 0) {
        return $array;
    }
    if (@$array < $L) {
        push(@$array, @{f($array, $L - @$array)});
    }
    return $array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3], 4),[1, 2, 3, 1, 2, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
