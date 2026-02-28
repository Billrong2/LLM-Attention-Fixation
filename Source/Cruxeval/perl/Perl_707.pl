# 
sub f {
    my($text, $position) = @_;
    my $length = length($text);
    my $index = $position % ($length + 1);
    if ($position < 0 || $index < 0) {
        $index = -1;
    }
    my @new_text = split(//, $text);
    splice(@new_text, $index, 1);
    return join('', @new_text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("undbs l", 1),"udbs l")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
