# 
sub f {
    my($text) = @_;
    my $short = '';
    for my $c (split('', $text)) {
        if ($c =~ /[a-z]/) {
            $short .= $c;
        }
    }
    return $short;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("980jio80jic kld094398IIl "),"jiojickldl")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
