# 
sub f {
    my($s1, $s2) = @_;
    if (substr($s2, -length($s1)) eq $s1) {
        $s2 = substr($s2, 0, length($s2) - length($s1));
    }
    return $s2;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("he", "hello"),"hello")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
