# 
sub f {
    my($a) = @_;
    my @b = @{$a};
    for(my $k = 0; $k < scalar(@{$a}) - 1; $k += 2) {
        splice(@b, $k + 1, 0, $b[$k]);
    }
    push(@b, $b[0]);
    return \@b;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([5, 5, 5, 6, 4, 9]),[5, 5, 5, 5, 5, 5, 6, 4, 9, 5])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
