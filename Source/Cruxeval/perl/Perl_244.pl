# 
sub f {
    my($text, $symbols) = @_;
    my $count = 0;
    if ($symbols) {
        foreach my $i (split('', $symbols)) {
            $count += 1;
        }
        $text = $text x $count;
    }
    return substr(' ' x ($count*2) . $text, 0, length($text) + $count*2 - 2);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("", "BC1ty"),"        ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
