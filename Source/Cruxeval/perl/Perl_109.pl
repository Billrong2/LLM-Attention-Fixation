# 
sub f {
    my($nums, $spot, $idx) = @_;
    splice(@$nums, $spot, 0, $idx);
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 0, 1, 1], 0, 9),[9, 1, 0, 1, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
