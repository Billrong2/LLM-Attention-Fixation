# 
sub f {
    my($array, $elem) = @_;
    my @array = @{$array};
    my $k = 0;
    my @l = @array;
    foreach my $i (@l) {
        if ($i > $elem) {
            splice(@array, $k, 0, $elem);
            last;
        }
        $k++;
    }
    return \@array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([5, 4, 3, 2, 1, 0], 3),[3, 5, 4, 3, 2, 1, 0])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
