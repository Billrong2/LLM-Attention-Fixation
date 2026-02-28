# 
sub f {
    my($update, $starting) = @_;
    my %d = %$starting;
    foreach my $k (keys %$update) {
        if (exists $d{$k}) {
            $d{$k} += $update->{$k};
        } else {
            $d{$k} = $update->{$k};
        }
    }
    return \%d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}, {"desciduous" => 2}),{"desciduous" => 2})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
