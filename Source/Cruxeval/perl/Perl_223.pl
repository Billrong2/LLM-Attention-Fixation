# 
sub f {
    my($array, $target) = @_;
    my $count = 0;
    my $i = 1;
    for my $j (1..scalar(@$array) - 1) {
        if (($array->[$j] > $array->[$j-1]) and ($array->[$j] <= $target)) {
            $count += $i;
        } elsif ($array->[$j] <= $array->[$j-1]) {
            $i = 1;
        } else {
            $i += 1;
        }
    }
    return $count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, -1, 4], 2),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
