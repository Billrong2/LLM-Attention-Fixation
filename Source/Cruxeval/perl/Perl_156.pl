# 
sub f {
    my($text, $limit, $char) = @_;
    if ($limit < length($text)) {
        return substr($text, 0, $limit);
    }
    return $text . $char x ($limit - length($text));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("tqzym", 5, "c"),"tqzym")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
