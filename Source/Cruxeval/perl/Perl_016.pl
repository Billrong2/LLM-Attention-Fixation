# 
sub f {
    my($text, $suffix) = @_;
    if (substr($text, -length($suffix)) eq $suffix) {
        return substr($text, 0, length($text) - length($suffix));
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("zejrohaj", "owc"),"zejrohaj")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
