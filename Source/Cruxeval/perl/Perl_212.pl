# 
sub f {
    my($nums) = @_;
    for my $i (0..scalar(@$nums) - 2) {
        @$nums = reverse @$nums;
    }
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, -9, 7, 2, 6, -3, 3]),[1, -9, 7, 2, 6, -3, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
