# 
sub f {
    my($array) = @_;
    my @result;
    my $index = 0;
    while ($index < scalar(@{$array})) {
        push @result, pop(@{$array});
        $index += 2;
    }
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([8, 8, -4, -9, 2, 8, -1, 8]),[8, -1, 8])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
