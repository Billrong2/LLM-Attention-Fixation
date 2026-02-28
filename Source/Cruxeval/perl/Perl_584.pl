# 
sub f {
    my($txt) = @_;
    return sprintf($txt, ('0' x 20));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("5123807309875480094949830"),"5123807309875480094949830")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
