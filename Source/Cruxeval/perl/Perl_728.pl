# 
sub f {
    my($text) = @_;
    my @result;
    my @chars = split(//, $text);
    for my $i (0..$#chars) {
        my $ch = $chars[$i];
        unless ($ch eq lc $ch) {
            if ($#chars - $i < rindex($text, lc $ch)) {
                push @result, $ch;
            }
        }
    }
    return join('', @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ru"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
