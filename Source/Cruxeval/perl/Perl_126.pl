# 
sub f {
    my($text) = @_;
    my @s = split('', $text);
    foreach my $i (@s) {
        if ($i eq 'o') {
            my $div = ($s[0] eq '' ? '-' : $s[0]);
            my $div2 = ($s[2] eq '' ? '-' : $s[2]);
            return $s[1] . $div . $s[1] . $div2;
        }
    }
    return '-' . $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("kkxkxxfck"),"-kkxkxxfck")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
