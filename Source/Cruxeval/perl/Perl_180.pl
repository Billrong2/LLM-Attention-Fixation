# 
sub f {
    my($nums) = @_;
    my @nums = @$nums;
    my $a = -1;
    my @b = @nums[1..$#nums];
    while ($a <= $b[0]) {
        @nums = grep { $_ != $b[0] } @nums;
        $a = 0;
        @b = @b[1..$#b];
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-1, 5, 3, -2, -6, 8, 8]),[-1, -2, -6, 8, 8])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
