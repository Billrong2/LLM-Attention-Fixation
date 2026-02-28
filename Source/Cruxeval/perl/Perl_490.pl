# 
sub f {
    my($s) = @_;
    return join('', grep { $_ =~ /\s/ } split('', $s));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("
giyixjkvu
 rgjuo"),"

 ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
