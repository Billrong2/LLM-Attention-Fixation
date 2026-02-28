# 
sub f {
    my($numbers, $num, $val) = @_;
    while (scalar(@$numbers) < $num) {
        splice(@$numbers, int(scalar(@$numbers) / 2), 0, $val);
    }
    for (my $i = 0; $i < int(scalar(@$numbers) / ($num - 1) - 4); $i++) {
        splice(@$numbers, int(scalar(@$numbers) / 2), 0, $val);
    }
    return join(' ', @$numbers);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([], 0, 1),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
