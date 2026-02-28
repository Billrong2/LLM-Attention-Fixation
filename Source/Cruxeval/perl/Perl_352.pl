# 
sub f {
    my($nums) = @_;
    return $nums->[int(@$nums/2)];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-1, -3, -5, -7, 0]),-5)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
