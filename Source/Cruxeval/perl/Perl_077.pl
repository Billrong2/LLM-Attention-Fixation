# 
sub f {
    my($text, $character) = @_;
    my $subject = substr($text, rindex($text, $character));
    return $subject x (() = $text =~ /$character/g);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("h ,lpvvkohh,u", "i"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
