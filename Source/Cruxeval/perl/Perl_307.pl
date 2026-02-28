# 
sub f {
    my($text) = @_;
    my @rtext = split(//, $text);
    for my $i (1 .. scalar(@rtext) - 2) {
        splice(@rtext, $i + 1, 0, '|');
    }
    return join('', @rtext);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("pxcznyf"),"px|||||cznyf")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
