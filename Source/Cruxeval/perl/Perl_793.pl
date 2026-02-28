# 
sub f {
    my($lst, $start, $end) = @_;
    my $count = 0;
    for my $i ($start..$end-1) {
        for my $j ($i..$end-1) {
            if ($lst->[$i] != $lst->[$j]) {
                $count += 1;
            }
        }
    }
    return $count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 4, 3, 2, 1], 0, 3),3)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
