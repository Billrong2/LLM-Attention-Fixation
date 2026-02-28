sub f {
    my($text, $sub) = @_;
    my $a = 0;
    my $b = length($text) - 1;

    while ($a <= $b) {
        my $c = int(($a + $b) / 2);
        if (rindex($text, $sub) >= $c) {
            $a = $c + 1;
        }
        else {
            $b = $c - 1;
        }
    }

    return $a;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("dorfunctions", "2"),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
