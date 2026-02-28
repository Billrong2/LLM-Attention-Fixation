# 
sub f {
    my($ints) = @_;
    my @counts = (0) x 301;

    foreach my $i (@$ints) {
        $counts[$i]++;
    }

    my @r = ();
    foreach my $i (0..$#counts) {
        if ($counts[$i] >= 3) {
            push @r, $i;
        }
    }
    @counts = ();
    return join(' ', @r);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([2, 3, 5, 2, 4, 5, 2, 89]),"2")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
