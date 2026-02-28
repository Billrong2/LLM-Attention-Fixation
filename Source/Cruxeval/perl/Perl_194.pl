# 
sub f {
    my($matr, $insert_loc) = @_;
    splice(@$matr, $insert_loc, 0, []);
    return $matr;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([[5, 6, 2, 3], [1, 9, 5, 6]], 0),[[], [5, 6, 2, 3], [1, 9, 5, 6]])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
