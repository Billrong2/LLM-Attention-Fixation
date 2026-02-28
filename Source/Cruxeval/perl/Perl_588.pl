# 
sub f {
    my($items, $target) = @_;
    my $index = -1;
    for my $i (0 .. $#$items) {
        if ($items->[$i] eq $target) {
            $index = $i;
            last;
        }
    }
    return $index;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["1", "+", "-", "**", "//", "*", "+"], "**"),3)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
