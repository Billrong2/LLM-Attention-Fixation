# 
sub f {
    my($nums, $start, $k) = @_;
    splice(@$nums, $start, $k, reverse(@$nums[$start..($start+$k-1)]));
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3, 4, 5, 6], 4, 2),[1, 2, 3, 4, 6, 5])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
