# 
sub f {
    my($n, $array) = @_;
    my @final = [@$array];
    for my $i (0..$n-1) {
        my @arr = @$array;
        push @arr, @{$final[-1]};
        push @final, \@arr;
    }
    return \@final;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(1, [1, 2, 3]),[[1, 2, 3], [1, 2, 3, 1, 2, 3]])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
