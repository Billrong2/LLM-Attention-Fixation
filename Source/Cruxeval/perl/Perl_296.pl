# 
sub f {
    my($url) = @_;
    $url =~ s/^http:\/\/www\.//;
    return $url;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("https://www.www.ekapusta.com/image/url"),"https://www.www.ekapusta.com/image/url")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
