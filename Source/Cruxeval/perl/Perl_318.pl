# 
sub f {
    my($value, $char) = @_;
    my $total = 0;
    foreach my $c (split(//, $value)) {
        if ($c eq $char or $c eq lc $char) {
            $total += 1;
        }
    }
    return $total;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("234rtccde", "e"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
