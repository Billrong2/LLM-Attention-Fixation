# 
sub f {
    my($text) = @_;
    $text = lc($text);
    my $capitalize = ucfirst($text);
    return substr($text, 0, 1) . substr($capitalize, 1);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("this And cPanel"),"this and cpanel")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
