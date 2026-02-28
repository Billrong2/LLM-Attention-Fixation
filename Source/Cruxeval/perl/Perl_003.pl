# 
sub f {
    my($text, $value) = @_;
    my @text_list = split(//, $text);
    push @text_list, $value;
    return join('', @text_list);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("bcksrut", "q"),"bcksrutq")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
