# 
sub f {
    my($nums) = @_;
    my @nums = @$nums;  # make a copy of nums
    my $count = scalar @nums;
    for (my $i = -$count+1; $i < 0; $i++) {
        unshift @nums, $nums[$i];
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([7, 1, 2, 6, 0, 2]),[2, 0, 6, 2, 1, 7, 1, 2, 6, 0, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
