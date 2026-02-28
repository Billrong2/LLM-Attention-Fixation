# 
sub f {
    my($text) = @_;
    my $a = 0;
    if (index($text, substr($text, 0, 1), 1) != -1) {
        $a += 1;
    }
    for my $i (0..length($text)-2) {
        if (index($text, substr($text, $i, 1), $i+1) != -1) {
            $a += 1;
        }
    }
    return $a;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("3eeeeeeoopppppppw14film3oee3"),18)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
