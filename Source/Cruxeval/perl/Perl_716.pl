# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $count = scalar @nums;
    while (scalar @nums > int($count/2)) {
        @nums = ();
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([2, 1, 2, 3, 1, 6, 3, 8]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
