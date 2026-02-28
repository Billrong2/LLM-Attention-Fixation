# 
sub f {
    my($array) = @_;
    for my $i (0..$#{$array}) {
        if ($array->[$i] < 0) {
            splice @{$array}, $i, 1;
            $i--; # adjust index after removing element
        }
    }
    return $array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
