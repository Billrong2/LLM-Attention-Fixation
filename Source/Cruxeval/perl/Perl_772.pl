# 
sub f {
    my($phrase) = @_;
    my $result = '';
    foreach my $i (split(//, $phrase)) {
        if ($i !~ /[a-z]/) {
            $result .= $i;
        }
    }
    return $result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("serjgpoDFdbcA."),"DFA.")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
