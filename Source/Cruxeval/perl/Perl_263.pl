# 
sub f {
    my($base, $delta) = @_;
    my @base = @{$base};
    my @delta = @{$delta};
    
    for my $j (0 .. $#delta) {
        for my $i (0 .. $#base) {
            if ($base[$i] eq $delta[$j][0]) {
                die "AssertionError" if $delta[$j][1] eq $base[$i];
                $base[$i] = $delta[$j][1];
            }
        }
    }
    return \@base;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["gloss", "banana", "barn", "lawn"], []),["gloss", "banana", "barn", "lawn"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
