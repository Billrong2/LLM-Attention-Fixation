# 
sub f {
    my($places, $lazy) = @_;
    @$places = sort { $a <=> $b } @$places;
    foreach my $l (@$lazy) {
        @$places = grep { $_ != $l } @$places;
    }
    if (scalar(@$places) == 1) {
        return 1;
    }
    foreach my $i (0..$#$places) {
        my $place = $places->[$i];
        my $count = grep { $_ == $place + 1 } @$places;
        if ($count == 0) {
            return $i + 1;
        }
    }
    return $i + 1;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([375, 564, 857, 90, 728, 92], [728]),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
