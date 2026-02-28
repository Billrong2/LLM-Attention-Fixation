# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $count = scalar @nums;
    for my $i (0..$count-1) {
        splice @nums, $i, 0, $nums[$i]*2;
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([2, 8, -2, 9, 3, 3]),[4, 4, 4, 4, 4, 4, 2, 8, -2, 9, 3, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
