# 
sub f {
    my($string) = @_;
    if (substr($string, 0, 4) ne 'Nuva') {
        return 'no';
    } else {
        return (split('\s', $string))[0];
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Nuva?dlfuyjys"),"Nuva?dlfuyjys")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
