# 
sub f {
    my($array, $ind, $elem) = @_;
    splice(@$array, $ind < 0 ? -5 : $ind > scalar(@$array) ? scalar(@$array) : $ind + 1, 0, $elem);
    return $array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 5, 8, 2, 0, 3], 2, 7),[1, 5, 8, 7, 2, 0, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
