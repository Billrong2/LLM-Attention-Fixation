# 
sub f {
    my($strs) = @_;
    my @strs = split(' ', $strs);
    for (my $i = 1; $i < scalar @strs; $i += 2) {
        my @chars = reverse(split('', $strs[$i]));
        $strs[$i] = join('', @chars);
    }
    return join(' ', @strs);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("K zBK"),"K KBz")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
