# 
sub f {
    my($text, $position, $value) = @_;
    my $length = length($text);
    my $index = ($position % ($length + 2)) - 1;
    if ($index >= $length || $index < 0) {
        return $text;
    }
    my @text_list = split('', $text);
    $text_list[$index] = $value;
    return join('', @text_list);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("1zd", 0, "m"),"1zd")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
