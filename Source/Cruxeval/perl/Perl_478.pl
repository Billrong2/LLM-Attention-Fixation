# 
sub f {
    my($sb) = @_;
    my %d;
    foreach my $s (split("", $sb)) {
        $d{$s} = $d{$s} ? $d{$s} + 1 : 1;
    }
    return \%d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("meow meow"),{"m" => 2, "e" => 2, "o" => 2, "w" => 2, " " => 1})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
