# 
sub f {
    my($text, $amount) = @_;
    my $length = length($text);
    my $pre_text = '|';
    if ($amount >= $length) {
        my $extra_space = $amount - $length;
        $pre_text .= ' ' x int($extra_space / 2);
        return $pre_text . $text . $pre_text;
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("GENERAL NAGOOR", 5),"GENERAL NAGOOR")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
