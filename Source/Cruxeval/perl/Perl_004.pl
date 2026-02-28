# 
sub f {
    my($array) = @_;
    my $s = ' ';
    $s .= join('', @$array);
    return $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([" ", "  ", "    ", "   "]),"           ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
