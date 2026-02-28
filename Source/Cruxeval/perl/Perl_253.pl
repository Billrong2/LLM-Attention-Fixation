# 
sub f {
    my($text, $pref) = @_;
    my $length = length($pref);
    if ($pref eq substr($text, 0, $length)) {
        return substr($text, $length);
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("kumwwfv", "k"),"umwwfv")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
