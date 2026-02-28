# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $count = scalar @nums;
    for (my $i = $count-1; $i > 0; $i -= 2) {
        splice @nums, $i, 0, shift(@nums) + shift(@nums);
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-5, 3, -2, -3, -1, 3, 5]),[5, -2, 2, -5])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
