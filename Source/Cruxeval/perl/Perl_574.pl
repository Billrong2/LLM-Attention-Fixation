# 
sub f {
    my($simpons) = @_;
    while (scalar(@$simpons)) {
        my $pop = pop(@$simpons);
        if ($pop eq ucfirst($pop)) {
            return $pop;
        }
    }
    return $pop;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["George", "Michael", "George", "Costanza"]),"Costanza")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
