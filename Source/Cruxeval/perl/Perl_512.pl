# 
sub f {
    my($s) = @_;
    return length($s) == (() = $s =~ /0/g) + (() = $s =~ /1/g);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("102"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
