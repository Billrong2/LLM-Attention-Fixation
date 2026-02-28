# 
sub f {
    my($text, $delim) = @_;
    my $index = rindex($text, $delim);
    return substr($text, 0, length($text) - $index - length($delim));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("dsj osq wi w", " "),"d")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
