# 
sub f {
    my($text) = @_;
    return ($text =~ /^[a-zA-Z]+$/) ? 1 : 0;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("x"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
