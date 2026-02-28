# 
sub f {
    my($chemicals, $num) = @_;
    my @fish = @{$chemicals}[1..$#{$chemicals}];
    @{$chemicals} = reverse @{$chemicals};
    for my $i (0..$num-1) {
        push @fish, splice(@{$chemicals}, 1, 1);
    }
    @{$chemicals} = reverse @{$chemicals};
    return $chemicals;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["lsi", "s", "t", "t", "d"], 0),["lsi", "s", "t", "t", "d"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
