# 
sub f {
    my($digits) = @_;
    my @digits = @$digits;
    @digits = reverse @digits;
    if (scalar @digits < 2) {
        return \@digits;
    }
    for my $i (0..$#digits) {
        if ($i % 2 == 0 && $i + 1 <= $#digits) {
            ($digits[$i], $digits[$i+1]) = ($digits[$i+1], $digits[$i]);
        }
    }
    return \@digits;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2]),[1, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
