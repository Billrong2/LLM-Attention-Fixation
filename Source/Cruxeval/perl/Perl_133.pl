# 
sub f {
    my($nums, $elements) = @_;
    my @result;
    for my $i (0..scalar(@{$elements})-1) {
        push @result, pop @{$nums};
    }
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([7, 1, 2, 6, 0, 2], [9, 0, 3]),[7, 1, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
