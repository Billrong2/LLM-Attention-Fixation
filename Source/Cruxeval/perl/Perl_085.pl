# 
sub f {
    my($n) = @_;
    my %values = (0 => 3, 1 => 4.5, 2 => '-');
    my %res;
    foreach my $i (keys %values) {
        my $j = $values{$i};
        if ($i % $n != 2) {
            $res{$j} = int($n / 2);
        }
    }
    my @sorted_res = sort keys %res;
    return \@sorted_res;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(12),[3, 4.5])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
