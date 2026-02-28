# 
sub f {
    my($text) = @_;
    my $count = 0;
    my @punctuation = qw(. ? ! , .);
    foreach my $char (split('', $text)) {
        $count++ if $char ~~ @punctuation;
    }
    return $count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("bwiajegrwjd??djoda,?"),4)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
