# 
sub f {
    my($text) = @_;
    my $new_text = $text;
    while (length($text) > 1 && substr($text, 0, 1) eq substr($text, -1, 1)) {
        $new_text = $text = substr($text, 1, length($text) - 2);
    }
    return $new_text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(")"),")")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
