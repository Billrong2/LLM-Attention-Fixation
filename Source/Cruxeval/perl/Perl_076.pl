# 
sub f {
    my($nums) = @_;
    my @nums = grep { $_ > 0 } @{$nums};
    if (scalar @nums <= 3) {
        return \@nums;
    }
    @nums = reverse @nums;
    my $half = int(@nums/2);
    return [ @nums[0..$half-1], (0)x5, @nums[$half..$#nums] ];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([10, 3, 2, 2, 6, 0]),[6, 2, 0, 0, 0, 0, 0, 2, 3, 10])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
