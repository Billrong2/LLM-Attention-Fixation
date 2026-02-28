# 
sub f {
    my($text, $value) = @_;
    my $length = length($text);
    my @letters = split('', $text);
    if (index($text, $value) == -1) {
        $value = $letters[0];
    }
    return $value x $length;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ldebgp o", "o"),"oooooooo")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
