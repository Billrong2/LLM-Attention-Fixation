# 
sub f {
    my($text, $strip_chars) = @_;
    $text = reverse($text);
    $text =~ s/^[$strip_chars]+//;
    $text =~ s/[$strip_chars]+$//;
    $text = reverse($text);
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("tcmfsmj", "cfj"),"tcmfsm")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
