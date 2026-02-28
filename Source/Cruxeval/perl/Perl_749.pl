# 
sub f {
    my($text, $width) = @_;
    my @lines = split /\n/, $text;
    my $result = "";
    foreach my $l (@lines) {
        $result .= substr(" " x $width, 0, int(($width - length $l) / 2)) . "$l" . substr(" " x $width, 0, $width - length $l - int(($width - length $l) / 2));
        $result .= "\n";
    }
    $result = substr($result, 0, -1);
    return $result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("l
l", 2),"l 
l ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
