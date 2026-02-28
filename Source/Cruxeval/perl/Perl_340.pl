# 
sub f {
    my($text) = @_;
    my $uppercase_index = index($text, 'A');
    if ($uppercase_index >= 0) {
        return substr($text, 0, $uppercase_index) . substr($text, index($text, 'a') + 1);
    } else {
        return join('', sort(split('', $text)));
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("E jIkx HtDpV G"),"   DEGHIVjkptx")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
