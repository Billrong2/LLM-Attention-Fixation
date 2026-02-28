# 
sub f {
    my($s, $l) = @_;
    return substr($s . '=' x ($l - length($s)), 0, $l - 1);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("urecord", 8),"urecord")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
