# 
sub f {
    my($xs) = @_;
    my @xs = @{$xs};
    my $new_x = $xs[0] - 1;
    shift @xs;
    while ($new_x <= $xs[0]) {
        shift @xs;
        $new_x -= 1;
    }
    unshift @xs, $new_x;
    return \@xs;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([6, 3, 4, 1, 2, 3, 5]),[5, 3, 4, 1, 2, 3, 5])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
