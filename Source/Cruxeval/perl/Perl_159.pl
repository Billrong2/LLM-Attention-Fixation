# 
sub f {
    my($st) = @_;
    my $swapped = '';
    foreach my $ch (reverse(split(//, $st))) {
        $swapped .= uc($ch) eq $ch ? lc($ch) : uc($ch);
    }
    return $swapped;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("RTiGM"),"mgItr")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
