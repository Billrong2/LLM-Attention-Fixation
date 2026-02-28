# 
sub f {
    my($numbers, $index) = @_;
    foreach my $n (@{$numbers}[$index..$#{$numbers}]) {
        splice @{$numbers}, $index, 0, $n;
        $index++;
    }
    return [@{$numbers}[0..$index-1]];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-2, 4, -4], 0),[-2, 4, -4])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
