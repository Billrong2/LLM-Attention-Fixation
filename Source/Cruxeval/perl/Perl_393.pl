# 
sub f {
    my($text) = @_;
    my $ls = reverse($text);
    my $text2 = '';
    for (my $i = length($ls) - 3; $i > 0; $i -= 3) {
        $text2 .= join('---', split(//, substr($ls, $i, 3))) . '---';
    }
    return substr($text2, 0, -3);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("scala"),"a---c---s")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
