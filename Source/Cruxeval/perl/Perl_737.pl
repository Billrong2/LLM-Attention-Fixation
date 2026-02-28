# 
sub f {
    my($nums) = @_;
    my $counts = 0;
    foreach my $i (@{$nums}) {
        if ($i =~ /^\d+$/) {
            if ($counts == 0) {
                $counts += 1;
            }
        }
    }
    return $counts;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([0, 6, 2, -1, -2]),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
