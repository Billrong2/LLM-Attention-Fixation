# 
sub f {
    my($text, $suffix) = @_;
    if ($suffix =~ m|^/|) {
        return $text . substr($suffix, 1);
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("hello.txt", "/"),"hello.txt")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
