# 
sub f {
    my($string, $encryption) = @_;
    if ($encryption == 0) {
        return $string;
    } else {
        return uc($string);
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("UppEr", 0),"UppEr")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
