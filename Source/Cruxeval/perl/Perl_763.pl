# 
sub f {
    my($values, $text, $markers) = @_;
    return $text =~ s/[$values$markers]+$//r;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("2Pn", "yCxpg2C2Pny2", ""),"yCxpg2C2Pny")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
