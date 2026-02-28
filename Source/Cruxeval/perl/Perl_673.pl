# 
sub f {
    my($string) = @_;
    if ($string eq uc $string) {
        return lc $string;
    } elsif ($string eq lc $string) {
        return uc $string;
    }
    return $string;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("cA"),"cA")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
