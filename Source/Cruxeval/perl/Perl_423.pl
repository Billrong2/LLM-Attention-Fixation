# 
sub f {
    my($selfie) = @_;
    my @selfie = @{$selfie};
    my $lo = scalar @selfie;
    for my $i (reverse 0..$lo-1) {
        if ($selfie[$i] == $selfie[0]) {
            splice @selfie, $lo-1, 1;
        }
    }
    return \@selfie;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([4, 2, 5, 1, 3, 2, 6]),[4, 2, 5, 1, 3, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
