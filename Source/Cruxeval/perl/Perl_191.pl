# 
sub f {
    my($string) = @_;
    return $string eq uc($string);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Ohno"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
