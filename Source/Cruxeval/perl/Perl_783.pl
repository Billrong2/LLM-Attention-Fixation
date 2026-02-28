# 
sub f {
    my($text, $comparison) = @_;
    my $length = length($comparison);
    if ($length <= length($text)) {
        for my $i (0..$length-1) {
            if (substr($comparison, $length-$i-1, 1) ne substr($text, length($text)-$i-1, 1)) {
                return $i;
            }
        }
    }
    return $length;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("managed", ""),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
