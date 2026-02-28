# 
sub f {
    my($string, $numbers) = @_;
    my @arr;
    foreach my $num (@$numbers) {
        push @arr, sprintf("%0*d", $num, $string);
    }
    return join(' ', @arr);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("4327", [2, 8, 9, 2, 7, 1]),"4327 00004327 000004327 4327 0004327 4327")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
