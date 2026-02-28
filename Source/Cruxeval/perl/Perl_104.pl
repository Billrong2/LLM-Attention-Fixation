# 
sub f {
    my($text) = @_;
    my %dic;
    my @chars = split('', $text);
    foreach my $char (@chars) {
        $dic{$char} = $dic{$char} ? $dic{$char} + 1 : 1;
    }
    foreach my $key (keys %dic) {
        if ($dic{$key} > 1) {
            $dic{$key} = 1;
        }
    }
    return \%dic;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a"),{"a" => 1})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
