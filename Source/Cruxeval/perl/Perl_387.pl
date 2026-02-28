# 
sub f {
    my($nums, $pos, $value) = @_;
    splice(@$nums, $pos, 0, $value);
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([3, 1, 2], 2, 0),[3, 1, 0, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
