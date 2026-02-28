# 
sub f {
    my($a, $b) = @_;
    return join($a, @{$b});
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("00", ["nU", " 9 rCSAz", "w", " lpA5BO", "sizL", "i7rlVr"]),"nU00 9 rCSAz00w00 lpA5BO00sizL00i7rlVr")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
