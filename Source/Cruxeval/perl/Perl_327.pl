# 
sub f {
    my($lst) = @_;
    my @new = ();
    my $i = scalar(@{$lst}) - 1;
    for (0..$#{$lst}) {
        if ($i % 2 == 0) {
            push @new, -$lst->[$i];
        } else {
            push @new, $lst->[$i];
        }
        $i--;
    }
    return \@new;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 7, -1, -3]),[-3, 1, 7, -1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
