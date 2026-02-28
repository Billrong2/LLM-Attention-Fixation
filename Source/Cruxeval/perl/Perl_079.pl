# 
sub f {
    my($arr) = @_;
    my @arr = @{$arr};
    @arr = ();
    push @arr, '1';
    push @arr, '2';
    push @arr, '3';
    push @arr, '4';
    return join(',', @arr);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([0, 1, 2, 3, 4]),"1,2,3,4")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
