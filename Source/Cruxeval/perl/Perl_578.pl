# 
sub f {
    my($obj) = @_;
    foreach my $k (keys %$obj) {
        my $v = $obj->{$k};
        if ($v >= 0) {
            $obj->{$k} = -$v;
        }
    }
    return $obj;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"R" => 0, "T" => 3, "F" => -6, "K" => 0}),{"R" => 0, "T" => -3, "F" => -6, "K" => 0})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
