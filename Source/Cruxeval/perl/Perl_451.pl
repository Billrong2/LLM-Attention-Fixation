# 
sub f {
    my($text, $char) = @_;
    my @text = split('', $text);
    foreach my $index (0..$#text) {
        if ($text[$index] eq $char) {
            splice(@text, $index, 1);
            return join('', @text);
        }
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("pn", "p"),"n")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
