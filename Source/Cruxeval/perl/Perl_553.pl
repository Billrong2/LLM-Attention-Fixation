# 
sub f {
    my($text, $count) = @_;
    foreach my $i (1..$count) {
        $text = reverse $text;
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("439m2670hlsw", 3),"wslh0762m934")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
