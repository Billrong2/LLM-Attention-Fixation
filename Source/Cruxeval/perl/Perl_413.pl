# 
sub f {
    my($s) = @_;
    return substr($s, 3) . substr($s, 2, 1) . substr($s, 5, 3);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("jbucwc"),"cwcuc")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
