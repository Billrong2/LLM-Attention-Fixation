# 
sub f {
    my($text) = @_;
    my $s = 0;
    foreach my $i (1..length($text)-1) {
        $s += length(substr($text, 0, rindex($text, substr($text, $i, 1))));
    }
    return $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("wdj"),3)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
