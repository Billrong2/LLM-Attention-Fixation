# 
sub f {
    my($text, $char) = @_;
    my $char_index = index($text, $char);
    my @result = ();
    if ($char_index > 0) {
        @result = split(//, substr($text, 0, $char_index));
    }
    push @result, split(//, $char), split(//, substr($text, $char_index+length($char)));
    return join('', @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("llomnrpc", "x"),"xllomnrpc")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
