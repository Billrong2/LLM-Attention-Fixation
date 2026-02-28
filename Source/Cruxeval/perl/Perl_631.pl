sub f {
    my($text, $num) = @_;
    my $req = $num - length $text;
    $text = '*' x (($req // 2) - $num // 2) . $text . '*' x ($req // 2);
    my $start = $req // 2;
    my $end = -$req // 2;
    return substr($text, $start, -$end);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a", 19),"*")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
