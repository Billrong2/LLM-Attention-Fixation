# 
sub f {
    my($s) = @_;
    while (@$s > 1) {
        @$s = ();  # clear the array
        push @$s, scalar(@$s);
    }
    return pop @$s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([6, 1, 2, 3]),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
