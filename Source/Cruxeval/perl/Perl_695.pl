# 
sub f {
    my($d) = @_;
    my %result;
    foreach my $ki (keys %$d) {
        $result{$ki} = [];
        my $li = $d->{$ki};
        foreach my $kj (0 .. $#{$li}) {
            push @{$result{$ki}}, {};
            my $dj = $li->[$kj];
            foreach my $kk (keys %$dj) {
                $result{$ki}[$kj]{$kk} = {%{$dj->{$kk}}};
            }
        }
    }
    return \%result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
