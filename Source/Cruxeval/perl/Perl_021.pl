# 
sub f {
    my($array) = @_;
    my $n = pop @$array;
    push @$array, $n, $n;
    return $array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 1, 2, 2]),[1, 1, 2, 2, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
