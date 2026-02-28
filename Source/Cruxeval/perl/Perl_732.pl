# 
sub f {
    my($char_freq) = @_;
    my %result;
    while (my($k, $v) = each %$char_freq) {
        $result{$k} = int($v / 2);
    }
    return \%result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"u" => 20, "v" => 5, "b" => 7, "w" => 3, "x" => 3}),{"u" => 10, "v" => 2, "b" => 3, "w" => 1, "x" => 1})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
