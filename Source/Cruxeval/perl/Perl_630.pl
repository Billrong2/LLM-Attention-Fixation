# 
sub f {
    my($original, $string) = @_;
    my %temp = %$original;
    while (my ($a, $b) = each %$string) {
        $temp{$b} = $a;
    }
    return \%temp;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({1 => -9, 0 => -7}, {1 => 2, 0 => 3}),{1 => -9, 0 => -7, 2 => 1, 3 => 0})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
