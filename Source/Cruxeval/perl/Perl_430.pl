# 
sub f {
    my($arr1, $arr2) = @_;
    my @new_arr = @$arr1;
    push @new_arr, @$arr2;
    return \@new_arr;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([5, 1, 3, 7, 8], ["", 0, -1, []]),[5, 1, 3, 7, 8, "", 0, -1, []])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
