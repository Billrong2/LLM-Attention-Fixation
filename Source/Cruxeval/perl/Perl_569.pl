# 
sub f {
    my($txt) = @_;
    my %coincidences;
    
    foreach my $c (split '', $txt) {
        if (exists $coincidences{$c}) {
            $coincidences{$c} += 1;
        } else {
            $coincidences{$c} = 1;
        }
    }
    
    my $sum = 0;
    foreach my $value (values %coincidences) {
        $sum += $value;
    }
    
    return $sum;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("11 1 1"),6)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
