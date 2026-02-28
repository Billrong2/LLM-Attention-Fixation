# 
sub f {
    my($text, $substr, $occ) = @_;
    my $n = 0;
    while (1) {
        my $i = rindex($text, $substr);
        if ($i == -1) {
            last;
        } elsif ($n == $occ) {
            return $i;
        } else {
            $n++;
            $text = substr($text, 0, $i);
        }
    }
    return -1;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("zjegiymjc", "j", 2),-1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
