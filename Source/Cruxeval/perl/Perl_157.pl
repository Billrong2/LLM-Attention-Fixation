# 
sub f {
    my($phrase) = @_;
    my $ans = 0;
    my @words = split(' ', $phrase);
    foreach my $word (@words) {
        foreach my $char (split('', $word)) {
            if ($char eq "0") {
                $ans += 1;
            }
        }
    }
    return $ans;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("aboba 212 has 0 digits"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
