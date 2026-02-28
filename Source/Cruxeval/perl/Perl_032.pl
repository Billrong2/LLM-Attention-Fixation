# 
sub f {
    my($s, $sep) = @_;
    my @reverse = map {'*' . $_} split /$sep/, $s;
    return join(';', reverse @reverse);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("volume", "l"),"*ume;*vo")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
