# 
sub f {
    my($s, $amount) = @_;
    return ('z' x ($amount - length($s))) . $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abc", 8),"zzzzzabc")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
