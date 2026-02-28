# 
sub f {
    my($input_string, $spaces) = @_;
    return $input_string;
}

use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a\tb", 4),"a\tb")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
