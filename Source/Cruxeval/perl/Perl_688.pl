# 
sub f {
    my($nums) = @_;
    my @l;
    my %seen;
    foreach my $i (@$nums) {
        push @l, $i unless $seen{$i};
        $seen{$i} = 1;
    }
    return \@l;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([3, 1, 9, 0, 2, 0, 8]),[3, 1, 9, 0, 2, 8])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
