# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $a = 0;
    for my $i (0..$#nums) {
        splice @nums, $i, 0, $nums[$a];
        $a++;
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 3, -1, 1, -2, 6]),[1, 1, 1, 1, 1, 1, 1, 3, -1, 1, -2, 6])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
