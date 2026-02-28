# 
sub f {
    my($text, $chars) = @_;
    my @listchars = split('', $chars);
    my $first = shift @listchars;
    foreach my $i (@listchars) {
        $text = substr($text, 0, index($text, $i)) . $i . substr($text, index($text, $i) + 1);
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("tflb omn rtt", "m"),"tflb omn rtt")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
