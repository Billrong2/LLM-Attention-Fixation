# 
sub f {
    my($array) = @_;
    my @result = reverse(@$array);
    @result = map { $_ * 2 } @result;
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3, 4, 5]),[10, 8, 6, 4, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
