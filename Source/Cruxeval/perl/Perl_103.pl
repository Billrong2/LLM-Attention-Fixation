# 
sub f {
    my($s) = @_;
    return join('', map {lc($_)} split(//, $s));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abcDEFGhIJ"),"abcdefghij")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
