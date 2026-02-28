# 
sub f {
    my($mess, $char) = @_;
    while (index($mess, $char, rindex($mess, $char) + 1) != -1) {
        my $index = rindex($mess, $char) + 1;
        $mess = substr($mess, 0, $index) . substr($mess, $index + 1);
    }
    return $mess;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("0aabbaa0b", "a"),"0aabbaa0b")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
