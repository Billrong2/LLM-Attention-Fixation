# 
sub f {
    my($nums, $n) = @_;
    return splice(@{$nums}, $n, 1);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-7, 3, 1, -1, -1, 0, 4], 6),4)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
