# 
sub f {
    my($text, $char) = @_;
    return lc($char) eq $char && lc($text) eq $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abc", "e"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
