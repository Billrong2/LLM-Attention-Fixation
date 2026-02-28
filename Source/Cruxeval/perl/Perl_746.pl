# 
sub f {
    my($dct) = @_;
    my %result;
    foreach my $value (values %$dct) {
        my $item = (split /\./, $value)[0] . '@pinc.uk';
        $result{$value} = $item;
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
