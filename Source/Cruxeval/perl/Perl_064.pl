# 
sub f {
    my($text, $size) = @_;
    my $counter = length($text);
    for my $i (0..int($size-int($size%2))) {
        $text = ' ' . $text . ' ';
        $counter += 2;
        if ($counter >= $size) {
            return $text;
        }
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("7", 10),"     7     ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
