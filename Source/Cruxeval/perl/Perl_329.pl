# 
sub f {
    my($text) = @_;
    for(my $i = 0; $i < length($text); $i++) {
        if(uc(substr($text, $i, 1)) eq substr($text, $i, 1) && lc(substr($text, $i-1, 1))) {
            return 1;
        }
    }
    return 0;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("jh54kkk6"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
