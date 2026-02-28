# 
sub f {
    my($name) = @_;
    return ($name->[0], reverse($name->[1])->[0]);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("master. "),["m", "a"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
