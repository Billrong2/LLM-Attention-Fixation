# 
sub f {
    my($nums, $i) = @_;
    splice(@$nums, $i, 1);
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([35, 45, 3, 61, 39, 27, 47], 0),[45, 3, 61, 39, 27, 47])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
