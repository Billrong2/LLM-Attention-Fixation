# 
sub f {
    my($text, $splitter) = @_;
    return join $splitter, split(' ', lc $text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("LlTHH sAfLAPkPhtsWP", "#"),"llthh#saflapkphtswp")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
