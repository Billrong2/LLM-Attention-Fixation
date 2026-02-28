# 
sub f {
    my($text, $char) = @_;
    my $index = rindex($text, $char);
    my @result = split('', $text);
    while ($index > 0) {
        $result[$index] = $result[$index-1];
        $result[$index-1] = $char;
        $index -= 2;
    }
    return join('', @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("qpfi jzm", "j"),"jqjfj zm")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
