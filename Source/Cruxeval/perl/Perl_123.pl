# 
sub f {
    my($array, $elem) = @_;
    my @array = @{$array};
    for my $idx (0..$#array) {
        if ($array[$idx] > $elem && $array[$idx - 1] < $elem) {
            splice @array, $idx, 0, $elem;
        }
    }
    return \@array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3, 5, 8], 6),[1, 2, 3, 5, 6, 8])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
