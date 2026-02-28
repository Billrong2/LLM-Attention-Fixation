# 
sub f {
    my($nums, $index) = @_;
    return $nums->[$index] % 42 + splice(@$nums, $index, 1) * 2;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([3, 2, 0, 3, 7], 3),9)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
