# 
sub f {
    my($text) = @_;
    my @k = split("\n", $text);
    my $i = 0;
    foreach my $j (@k) {
        if (length($j) == 0) {
            return $i;
        }
        $i += 1;
    }
    return -1;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("2 m2 

bike"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
