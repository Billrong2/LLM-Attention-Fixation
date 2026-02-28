# 
sub f {
    my($text, $n) = @_;
    if(length($text) <= 2) {
        return $text;
    }
    my $leading_chars = substr($text, 0, 1) x ($n - length($text) + 1);
    return $leading_chars . substr($text, 1, -1) . substr($text, -1);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("g", 15),"g")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
