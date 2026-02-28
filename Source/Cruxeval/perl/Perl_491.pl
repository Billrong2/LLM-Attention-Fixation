# 
sub f {
    my($xs) = @_;
    for my $i (-1, -2, -3, -4) {
        push @$xs, (@{$xs}[$i], @{$xs}[$i]);
    }
    return $xs;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([4, 8, 8, 5]),[4, 8, 8, 5, 5, 5, 5, 5, 5, 5, 5, 5])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
