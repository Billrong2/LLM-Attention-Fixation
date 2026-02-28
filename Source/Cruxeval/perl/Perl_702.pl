# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $count = scalar(@nums);
    for (my $i = $#nums; $i >= 0; $i--) {
        my $num = shift @nums;
        splice @nums, $i, 0, $num;
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([0, -5, -4]),[-4, -5, 0])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
