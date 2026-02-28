sub f {
    my($text) = @_;
    my $ws = 0;
    foreach my $s (split //, $text) {
        if ($s =~ /\s/) {
            $ws += 1;
        }
    }
    return [$ws, length($text)];
}

use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("jcle oq wsnibktxpiozyxmopqkfnrfjds"),[2, 34])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
