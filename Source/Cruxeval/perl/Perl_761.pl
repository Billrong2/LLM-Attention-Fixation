# 
sub f {
    my($array) = @_;
    my @output = @$array;
    @output[grep { $_ % 2 == 0 } 0..$#output] = reverse @output[grep { $_ % 2 == 0 } 0..$#output];
    return [reverse @output];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
