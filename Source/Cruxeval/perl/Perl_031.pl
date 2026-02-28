# 
sub f {
    my($string) = @_;
    my $upper = 0;
    foreach my $c (split(//, $string)) {
        if (uc($c) eq $c) {
            $upper += 1;
        }
    }
    return $upper * (2, 1)[$upper % 2];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("PoIOarTvpoead"),8)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
