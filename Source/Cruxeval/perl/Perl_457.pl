# 
sub f {
    my($nums) = @_;
    my @count = (0..$#{$nums});
    for my $i (0..$#{$nums}) {
        pop @{$nums};
        if (@count) {
            shift @count;
        }
    }
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([3, 1, 7, 5, 6]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
