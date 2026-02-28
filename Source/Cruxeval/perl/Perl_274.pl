# 
sub f {
    my($nums, $target) = @_;
    my $count = 0;
    foreach my $n1 (@$nums) {
        foreach my $n2 (@$nums) {
            $count += ($n1 + $n2 == $target);
        }
    }
    return $count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3], 4),3)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
