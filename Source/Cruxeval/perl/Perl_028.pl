# 
sub f {
    my($mylist) = @_;
    my @revl = @{$mylist};
    my @revl_copy = reverse @{$mylist};
    @{$mylist} = sort {$b <=> $a} @{$mylist};
    return "@{$mylist}" eq "@revl_copy";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([5, 8]),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
