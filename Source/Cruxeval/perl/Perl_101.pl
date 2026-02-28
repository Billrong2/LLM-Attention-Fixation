# 
sub f {
    my($array, $i_num, $elem) = @_;
    splice(@$array, $i_num, 0, $elem);
    return $array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-4, 1, 0], 1, 4),[-4, 4, 1, 0])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
