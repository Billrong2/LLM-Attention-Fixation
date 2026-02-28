# 
sub f {
    my($nums) = @_;
    my @reversed_nums = reverse @{$nums};
    return join('', map {$_} @reversed_nums);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-1, 9, 3, 1, -2]),"-2139-1")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
