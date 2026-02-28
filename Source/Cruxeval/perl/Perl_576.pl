# 
sub f {
    my($array, $const) = @_;
    my @output = ('x');
    for my $i (1..scalar(@$array)) {
        if ($i % 2 != 0) {
            push @output, $array->[$i - 1] * -2;
        } else {
            push @output, $const;
        }
    }
    return \@output;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3], -1),["x", "-2", "-1", "-6"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
