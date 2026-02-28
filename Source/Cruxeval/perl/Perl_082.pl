# 
sub f {
    my($a, $b, $c, $d) = @_;
    return $a && $b || $c && $d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("CJU", "BFS", "WBYDZPVES", "Y"),"BFS")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
