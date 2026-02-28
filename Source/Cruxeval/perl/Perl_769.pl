# 
sub f {
    my($text) = @_;
    my @text_list = split(//, $text);
    foreach my $i (0..$#text_list) {
        $text_list[$i] = uc($text_list[$i]) eq $text_list[$i] ? lc($text_list[$i]) : uc($text_list[$i]);
    }
    return join('', @text_list);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("akA?riu"),"AKa?RIU")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
