# 
sub f {
    my($text) = @_;
    my $index = 1;
    my $text_len = length($text);
    while ($index < $text_len) {
        if (substr($text, $index, 1) ne substr($text, $index - 1, 1)) {
            $index += 1;
        } else {
            my $text1 = substr($text, 0, $index);
            my $text2 = substr($text, $index);
            $text2 =~ tr/a-zA-Z/A-Za-z/;
            return $text1 . $text2;
        }
    }
    $text =~ tr/a-zA-Z/A-Za-z/;
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("USaR"),"usAr")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
