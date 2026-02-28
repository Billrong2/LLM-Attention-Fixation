# 
sub f {
    my($text) = @_;
    while(index($text, 'nnet lloP') != -1) {
        $text =~ s/nnet lloP/nnet loLp/g;
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a_A_b_B3 "),"a_A_b_B3 ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
