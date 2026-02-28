# 
sub f {
    my($s, $n) = @_;
    return lc($s) eq lc($n);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("daaX", "daaX"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
