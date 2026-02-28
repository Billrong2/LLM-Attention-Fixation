# 
sub f {
    my($name) = @_;
    return join('*', split(' ', $name));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Fred Smith"),"Fred*Smith")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
