# 
sub f {
    my($array, $elem) = @_;
    my $found;
    $array = [reverse @$array];
    for my $i (0..$#$array) {
        if ($array->[$i] == $elem) {
            $found = $i;
            last;
        }
    }
    $array = [reverse @$array];
    return $found;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([5, -3, 3, 2], 2),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
