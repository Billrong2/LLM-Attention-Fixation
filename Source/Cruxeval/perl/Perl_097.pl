# 
sub f {
    my($lst) = @_;
    @{$lst} = ();
    
    foreach my $i (@{$lst}) {
        if ($i == 3) {
            return 0;
        }
    }
    
    return 1;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([2, 0]),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
