# 
sub f {
    my($text) = @_;
    my $m = 0;
    my $cnt = 0;
    my @words = split(' ', $text);
    foreach my $i (@words) {
        if (length($i) > $m) {
            $cnt += 1;
            $m = length($i);
        }
    }
    return $cnt;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl"),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
