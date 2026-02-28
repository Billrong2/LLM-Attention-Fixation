# 
sub f {
    my($array) = @_;
    my @array = @{$array};
    my $l = scalar @array;
    if ($l % 2 == 0) {
        @array = ();
    } else {
        @array = reverse @array;
    }
    return \@array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
