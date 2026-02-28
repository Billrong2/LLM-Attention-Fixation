# 
sub f {
    my($name) = @_;
    if (lc($name) eq $name) {
        $name = uc($name);
    } else {
        $name = lc($name);
    }
    return $name;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Pinneaple"),"pinneaple")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
