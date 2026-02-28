# 
sub f {
    my($text, $char) = @_;
    my $position = length($text);
    if (index($text, $char) >= 0) {
        $position = index($text, $char);
        if ($position > 1) {
            $position = ($position + 1) % length($text);
        }
    }
    return $position;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("wduhzxlfk", "w"),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
