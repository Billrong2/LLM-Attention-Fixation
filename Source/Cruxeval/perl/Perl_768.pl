# 
sub f {
    my($s, $o) = @_;
    if (index($s, $o) == 0) {
        return $s;
    }
    return $o . f($s, substr($o, -2) . reverse(substr($o, 0, -2)));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abba", "bab"),"bababba")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
