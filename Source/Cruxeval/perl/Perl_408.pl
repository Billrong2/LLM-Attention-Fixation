# 
sub f {
    my($m) = @_;
    @{$m} = reverse @{$m};
    return $m;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-4, 6, 0, 4, -7, 2, -1]),[-1, 2, -7, 4, 0, 6, -4])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
