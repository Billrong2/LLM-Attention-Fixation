sub f {
    my ($plot, $delin) = @_;
    my @plot = @$plot;
    if (grep { $_ == $delin } @plot) {
        my $split = 0;
        $split++ until $plot[$split] == $delin;
        my @first = @plot[0 .. $split - 1];
        my @second = @plot[$split + 1 .. $#plot];
        return [@first, @second];
    } else {
        return $plot;
    }
}

use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3, 4], 3),[1, 2, 4])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
