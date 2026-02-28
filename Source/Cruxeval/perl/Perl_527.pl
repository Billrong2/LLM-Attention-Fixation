# 
sub f {
    my($text, $value) = @_;
    return $text . ("?" x (length($value) - length($text)));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("!?", ""),"!?")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
