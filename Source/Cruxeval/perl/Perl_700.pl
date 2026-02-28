# 
sub f {
    my($text) = @_;
    return length($text) - (() = $text =~ s/bot//g);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Where is the bot in this world?"),30)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
