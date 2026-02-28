# 
sub f {
    my($x) = @_;
    return join(' ', reverse split('', $x));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("lert dna ndqmxohi3"),"3 i h o x m q d n   a n d   t r e l")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
