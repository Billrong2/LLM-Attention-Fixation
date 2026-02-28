# 
sub f {
    my($nums) = @_;
    @{$nums} = reverse @{$nums};
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-6, -2, 1, -3, 0, 1]),[1, 0, -3, 1, -2, -6])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
