# 
sub f {
    my($text, $search) = @_;
    return substr($search, 0, length($text)) eq $text ? 1 : 0;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("123", "123eenhas0"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
