# 
sub f {
    my($array, $elem) = @_;
    return scalar(grep {$_ == $elem} @$array) + $elem;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 1, 1], -2),-2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
