# 
sub f {
    my($s, $n, $c) = @_;
    my $width = length($c) * $n;
    while (length($s) < $width) {
        $s = $c . $s;
    }
    return $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(".", 0, "99"),".")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
