# 
sub f {
    my($val, $text) = @_;
    my @indices;
    for my $index (0 .. length($text) - 1) {
        push @indices, $index if substr($text, $index, 1) eq $val;
    }
    if (@indices == 0) {
        return -1;
    } else {
        return $indices[0];
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("o", "fnmart"),-1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
