# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    for (my $i = scalar @nums - 1; $i >= 0; $i--) {
        if ($nums[$i] % 2 == 1) {
            splice @nums, $i+1, 0, $nums[$i];
        }
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([2, 3, 4, 6, -2]),[2, 3, 3, 4, 6, -2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
