# 
sub f {
    my($text, $char) = @_;
    my $result = ' '.join(split /$char/, $text);
    return $result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a", "a")," ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
