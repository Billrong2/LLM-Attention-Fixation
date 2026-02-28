# 
sub f {
    my($text, $speaker) = @_;
    while (index($text, $speaker) == 0) {
        $text = substr($text, length($speaker));
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("[CHARRUNNERS]Do you know who the other was? [NEGMENDS]", "[CHARRUNNERS]"),"Do you know who the other was? [NEGMENDS]")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
