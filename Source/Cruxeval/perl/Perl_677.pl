# 
sub f {
    my($text, $length) = @_;
    $length = -$length if $length < 0;
    my $output = '';
    my @chars = split //, $text;
    for my $idx (0..$length-1) {
        if ($chars[$idx % scalar @chars] ne ' ') {
            $output .= $chars[$idx % scalar @chars];
        } else {
            last;
        }
    }
    return $output;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("I got 1 and 0.", 5),"I")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
