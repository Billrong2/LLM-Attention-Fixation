# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $count = scalar @nums;
    if ($count == 0) {
        @nums = (0) x int(pop @nums);
    } elsif ($count % 2 == 0) {
        @nums = ();
    } else {
        splice @nums, 0, $count/2;
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-6, -2, 1, -3, 0, 1]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
