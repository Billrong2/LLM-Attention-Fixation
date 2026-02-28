# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $count = scalar @nums;
    for my $i (map { $_ % 2 } 0..$count-1) {
        push @nums, $nums[$i];
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-1, 0, 0, 1, 1]),[-1, 0, 0, 1, 1, -1, 0, -1, 0, -1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
