# 
sub f {
    my($text) = @_;
    my $odd = '';
    my $even = '';
    my @chars = split('', $text);
    foreach my $i (0..$#chars) {
        if ($i % 2 == 0) {
            $even .= $chars[$i];
        } else {
            $odd .= $chars[$i];
        }
    }
    return $even . lc($odd);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Mammoth"),"Mmohamt")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
