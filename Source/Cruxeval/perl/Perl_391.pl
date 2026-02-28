# 
sub f {
    my($students) = @_;
    my @seatlist = @{$students};
    @seatlist = reverse @seatlist;
    my $cnt = 0;
    for my $i (0..$#seatlist) {
        $cnt += 2;
        splice @seatlist, $cnt-1, 1, '+';
    }
    push @seatlist, '+';
    return \@seatlist;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["r", "9"]),["9", "+", "+", "+"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
