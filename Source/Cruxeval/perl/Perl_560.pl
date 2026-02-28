# 
sub f {
    my($text) = @_;
    my $x = 0;
    if ($text =~ /^[a-z]+$/) {
        my @chars = split(//, $text);
        foreach my $c (@chars) {
            if ($c =~ /\d/ && $c < 9) {
                $x += 1;
            }
        }
    }
    return $x;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("591237865"),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
