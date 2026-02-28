# 
sub f {
    my($arr, $d) = @_;
    for my $i (1..$#$arr) {
        if ($i % 2 == 1) {
            $d->{$arr->[$i]} = $arr->[$i-1];
        }
    }
    return $d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["b", "vzjmc", "f", "ae", "0"], {}),{"vzjmc" => "b", "ae" => "f"})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
