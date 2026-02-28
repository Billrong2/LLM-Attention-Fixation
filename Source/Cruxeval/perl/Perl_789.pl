# 
sub f {
    my($text, $n) = @_;
    if ($n < 0 || length($text) <= $n) {
        return $text;
    }
    my $result = substr($text, 0, $n);
    my $i = length($result) - 1;
    while ($i >= 0) {
        if (substr($result, $i, 1) ne substr($text, $i, 1)) {
            last;
        }
        $i--;
    }
    return substr($text, 0, $i + 1);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("bR", -1),"bR")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
