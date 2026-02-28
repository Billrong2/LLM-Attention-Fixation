# 
sub f {
    my($s) = @_;
    my $count = 0;
    my @chars = split('', $s);
    foreach my $c (@chars) {
        if (rindex($s, $c) != index($s, $c)) {
            $count += 1;
        }
    }
    return $count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abca dea ead"),10)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
