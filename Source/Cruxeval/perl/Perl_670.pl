# 
sub f {
    my($a, $b) = @_;
    my %d = map { $a->[$_] => $b->[$_] } 0..$#{$a};
    @$a = sort { $d{$b} <=> $d{$a} } @$a;
    return [map { delete $d{$_} } @$a];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["12", "ab"], [2, 2]),[2, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
