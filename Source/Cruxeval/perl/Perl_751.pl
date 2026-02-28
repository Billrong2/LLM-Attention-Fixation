# 
sub f {
    my($text, $char, $min_count) = @_;
    my $count = () = $text =~ /$char/g;
    if ($count < $min_count) {
        return uc($text) ^ lc($text);
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("wwwwhhhtttpp", "w", 3),"wwwwhhhtttpp")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
