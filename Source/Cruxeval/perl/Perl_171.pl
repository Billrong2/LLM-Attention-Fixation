# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $count = int(@nums / 2);
    for (my $i = 0; $i < $count; $i++) {
        shift @nums;
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([3, 4, 1, 2, 3]),[1, 2, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
