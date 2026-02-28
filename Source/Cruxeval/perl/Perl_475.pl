# 
sub f {
    my($array, $index) = @_;
    if ($index < 0) {
        $index = scalar(@$array) + $index;
    }
    return $array->[$index];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1], 0),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
