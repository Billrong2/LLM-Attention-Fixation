# 
sub f {
    my($array) = @_;
    my @return_arr;
    foreach my $a (@$array) {
        push @return_arr, [@$a];
    }
    return \@return_arr;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([[1, 2, 3], [], [1, 2, 3]]),[[1, 2, 3], [], [1, 2, 3]])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
