# 
sub f {
    my($text, $ch) = @_;
    return scalar(() = $text =~ /$ch/g);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("This be Pirate's Speak for 'help'!", " "),5)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
