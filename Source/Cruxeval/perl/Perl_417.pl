# 
sub f {
    my($lst) = @_;
    my @lst = reverse @{$lst};
    pop @lst;
    @lst = reverse @lst;
    return \@lst;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([7, 8, 2, 8]),[8, 2, 8])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
