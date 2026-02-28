# 
sub f {
    my($text) = @_;
    my $length = length($text) / 2;
    my $left_half = substr($text, 0, $length);
    my $right_half = scalar reverse substr($text, $length);
    return $left_half . $right_half;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("n"),"n")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
