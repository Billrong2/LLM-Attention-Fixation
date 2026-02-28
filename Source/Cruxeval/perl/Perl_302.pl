# 
sub f {
    my($string) = @_;
    $string =~ s/needles/haystacks/g;
    return $string;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("wdeejjjzsjsjjsxjjneddaddddddefsfd"),"wdeejjjzsjsjjsxjjneddaddddddefsfd")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
