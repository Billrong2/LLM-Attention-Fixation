# 
sub f {
    my($L, $m, $start, $step) = @_;
    splice(@$L, $start, 0, $m);
    for my $x (reverse($start-1 .. 1)) {
        $start -= 1;
        splice(@$L, $start, 0, splice(@$L, firstidx { $_ == $m } @$L, 1));
    }
    return $L;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 7, 9], 3, 3, 2),[1, 2, 7, 3, 9])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
