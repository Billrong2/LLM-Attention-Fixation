# 
sub f {
    my($text) = @_;
    $text = lc($text);
    my $head = substr($text, 0, 1);
    my $tail = substr($text, 1);
    return uc($head) . $tail;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Manolo"),"Manolo")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
