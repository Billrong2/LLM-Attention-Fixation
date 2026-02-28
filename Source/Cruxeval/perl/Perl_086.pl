# 
sub f {
    my($instagram, $imgur, $wins) = @_;
    my @photos = ($instagram, $imgur);
    if ($instagram eq $imgur) {
        return $wins;
    }
    if ($wins == 1) {
        return pop @photos;
    } else {
        @photos = reverse @photos;
        return pop @photos;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["sdfs", "drcr", "2e"], ["sdfs", "dr2c", "QWERTY"], 0),["sdfs", "drcr", "2e"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
