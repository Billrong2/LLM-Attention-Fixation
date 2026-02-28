# 
sub f {
    my($array, $elem) = @_;
    my $ind = 0;
    foreach my $i (0..$#{$array}) {
        if ($array->[$i] == $elem) {
            $ind = $i;
            last;
        }
    }
    return $ind * 2 + $array->[-$ind - 1] * 3;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-1, 2, 1, -8, 2], 2),-22)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
