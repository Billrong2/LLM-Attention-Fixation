# 
sub f {
    my($d) = @_;
    my %dCopy = %$d;
    foreach my $key (keys %dCopy){
        foreach my $i (0..$#{$dCopy{$key}}){
            $dCopy{$key}[$i] = uc $dCopy{$key}[$i];
        }
    }
    return \%dCopy;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"X" => ["x", "y"]}),{"X" => ["X", "Y"]})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
