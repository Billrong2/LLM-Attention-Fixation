# 
sub f {
    my($text) = @_;
    my %freq;
    my @chars = split("", lc $text);
    foreach my $c (@chars) {
        if (exists $freq{$c}) {
            $freq{$c} += 1;
        } else {
            $freq{$c} = 1;
        }
    }
    return \%freq;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("HI"),{"h" => 1, "i" => 1})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
