# 
sub f {
    my($s, $p) = @_;
    my @arr = split /($p)/, $s;
    my $part_one = length($arr[0]);
    my $part_two = length($arr[1]);
    my $part_three = length($arr[2]);
    if ($part_one >= 2 and $part_two <= 2 and $part_three >= 2) {
        return join '', reverse($arr[0]), $arr[1], reverse($arr[2]), '#';
    }
    return join '', $arr[0], $arr[1], $arr[2];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("qqqqq", "qqq"),"qqqqq")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
