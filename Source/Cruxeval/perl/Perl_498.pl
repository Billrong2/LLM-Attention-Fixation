# 
sub f {
    my($nums, $idx, $added) = @_;
    splice(@$nums, $idx, 0, $added);
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([2, 2, 2, 3, 3], 2, 3),[2, 2, 3, 2, 3, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
