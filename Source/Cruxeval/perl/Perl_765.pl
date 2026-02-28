# 
sub f {
    my($text) = @_;
    return scalar(() = $text =~ /\d/g);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("so456"),3)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
