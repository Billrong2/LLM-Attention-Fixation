# 
sub f {
    my($lines) = @_;
    foreach my $i (0..scalar(@$lines)-1) {
        $lines->[$i] = sprintf("%*s", length($lines->[-1]), $lines->[$i]);
    }
    return $lines;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["dZwbSR", "wijHeq", "qluVok", "dxjxbF"]),["dZwbSR", "wijHeq", "qluVok", "dxjxbF"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
