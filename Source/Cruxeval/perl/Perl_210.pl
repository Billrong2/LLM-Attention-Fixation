# 
sub f {
    my($n, $m, $num) = @_;
    my @x_list = ($n..$m);
    my $j = 0;
    while (1) {
        $j = ($j + $num) % scalar(@x_list);
        if ($x_list[$j] % 2 == 0) {
            return $x_list[$j];
        }
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(46, 48, 21),46)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
