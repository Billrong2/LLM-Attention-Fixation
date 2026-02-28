# 
sub f {
    my($text, $letter) = @_;
    if (index($text, $letter) != -1) {
        my $start = index($text, $letter);
        return substr($text, $start + 1) . substr($text, 0, $start + 1);
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("19kefp7", "9"),"kefp719")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
