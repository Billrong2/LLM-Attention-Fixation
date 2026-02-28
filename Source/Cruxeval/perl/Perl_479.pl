# 
sub f {
    my($nums, $pop1, $pop2) = @_;
    splice(@$nums, $pop1 - 1, 1);
    splice(@$nums, $pop2 - 1, 1);
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 5, 2, 3, 6], 2, 4),[1, 2, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
