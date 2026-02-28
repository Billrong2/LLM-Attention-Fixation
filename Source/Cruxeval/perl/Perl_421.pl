# 
sub f {
    my($s, $n) = @_;
    if (length($s) < $n) {
        return $s;
    } else {
        return substr($s, $n);
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("try.", 5),"try.")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
