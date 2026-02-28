# 
sub f {
    my($nums, $rmvalue) = @_;
    my @res = @{$nums};
    while (grep { $_ == $rmvalue } @res) {
        my $index = 0;
        foreach my $num (@res) {
            if ($num == $rmvalue) {
                splice @res, $index, 1;
                if ($num != $rmvalue) {
                    push @res, $num;
                }
                last;
            }
            $index++;
        }
    }
    return \@res;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([6, 2, 1, 1, 4, 1], 5),[6, 2, 1, 1, 4, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
