# 
sub f {
    my($text, $char) = @_;
    if (substr($text, -length($char)) ne $char) {
        return f($char . $text, $char);
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("staovk", "k"),"staovk")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
