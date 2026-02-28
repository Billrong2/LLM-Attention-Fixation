# 
sub f {
    my($string, $prefix) = @_;
    if (index($string, $prefix) == 0) {
        return substr($string, length($prefix));
    }
    return $string;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Vipra", "via"),"Vipra")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
