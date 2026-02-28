# 
sub f {
    my($L) = @_;
    my @L = @{$L};
    my $N = scalar @L;
    for my $k (1..int($N/2)) {
        my $i = $k - 1;
        my $j = $N - $k;
        while ($i < $j) {
            # swap elements:
            ($L[$i], $L[$j]) = ($L[$j], $L[$i]);
            # update i, j:
            $i++;
            $j--;
        }
    }
    return \@L;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([16, 14, 12, 7, 9, 11]),[11, 14, 7, 12, 9, 16])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
