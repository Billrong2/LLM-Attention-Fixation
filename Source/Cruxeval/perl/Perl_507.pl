# 
sub f {
    my($text, $search) = @_;
    my $result = lc($text);
    return index($result, lc($search));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("car hat", "car"),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
