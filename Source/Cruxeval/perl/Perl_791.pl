# 
sub f {
    my($integer, $n) = @_;
    my $i = 1;
    my $text = $integer;
    while (($i + length($text)) < $n) {
        $i += length($text);
    }
    return sprintf("%0*d", $i + length($text), $text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(8999, 2),"08999")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
