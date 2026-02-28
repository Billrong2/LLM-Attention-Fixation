# 
sub f {
    my($string, $c) = @_;
    return substr($string, -length($c)) eq $c;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("wrsch)xjmb8", "c"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
