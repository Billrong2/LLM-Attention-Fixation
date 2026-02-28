# 
sub f {
    my($array, $index, $value) = @_;
    unshift @{$array}, $index + 1;
    if ($value >= 1) {
        splice @{$array}, $index, 0, $value;
    }
    return $array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([2], 0, 2),[2, 1, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
