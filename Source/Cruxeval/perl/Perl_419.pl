# 
sub f {
    my($text, $value) = @_;
    if (index($text, $value) == -1) {
        return '';
    }
    return (split(/$value/, $text))[0];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("mmfbifen", "i"),"mmfb")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
