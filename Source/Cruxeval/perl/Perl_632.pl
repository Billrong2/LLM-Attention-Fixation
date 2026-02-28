# 
sub f {
    my($lst) = @_;
    for my $i (reverse 1..scalar(@$lst) - 1) {
        for my $j (0..$i-1) {
            if ($lst->[$j] > $lst->[$j + 1]) {
                ($lst->[$j], $lst->[$j + 1]) = ($lst->[$j + 1], $lst->[$j]);
                @$lst = sort { $a <=> $b } @$lst;
            }
        }
    }
    return $lst;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([63, 0, 1, 5, 9, 87, 0, 7, 25, 4]),[0, 0, 1, 4, 5, 7, 9, 25, 63, 87])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
