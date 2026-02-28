# 
sub f {
    my($text) = @_;
    my $result = '';
    my $mid = int((length($text) - 1) / 2);
    for my $i (0..$mid-1) {
        $result .= substr($text, $i, 1);
    }
    for my $i ($mid..length($text)-2) {
        $result .= substr($text, $mid + length($text) - 1 - $i, 1);
    }
    return $result . substr($text, -1) x (length($text) - length($result));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("eat!"),"e!t!")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
