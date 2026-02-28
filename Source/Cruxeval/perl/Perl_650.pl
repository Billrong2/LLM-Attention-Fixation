# 
sub f {
    my($string, $substring) = @_;
    while (index($string, $substring) == 0) {
        $string = substr($string, length($substring));
    }
    return $string;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("", "A"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
