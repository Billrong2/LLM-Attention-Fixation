# 
sub f {
    my($text, $value) = @_;
    my $length = length($text);
    my $index = 0;
    while ($length > 0) {
        $value = substr($text, $index, 1) . $value;
        $length -= 1;
        $index += 1;
    }
    return $value;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("jao mt", "house"),"tm oajhouse")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
