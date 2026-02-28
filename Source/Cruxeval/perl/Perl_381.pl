# 
sub f {
    my($text, $num_digits) = @_;
    my $width = ($num_digits > 1) ? $num_digits : 1;
    return sprintf("%0${width}d", $text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("19", 5),"00019")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
