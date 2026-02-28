# 
sub f {
    my($lst, $mode) = @_;
    my @result = @{$lst};
    if ($mode) {
        @result = reverse @result;
    }
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3, 4], 1),[4, 3, 2, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
