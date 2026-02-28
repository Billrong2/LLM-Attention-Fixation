# 
sub f {
    my($text) = @_;
    my($string_a, $string_b) = split(',', $text);
    return -(length($string_a) + length($string_b));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("dog,cat"),-6)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
