# 
sub f {
    my($numbers, $prefix) = @_;
    my @result = sort map { (length($_) > length($prefix) && substr($_, 0, length($prefix)) eq $prefix) ? substr($_, length($prefix)) : $_ } @$numbers;
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["ix", "dxh", "snegi", "wiubvu"], ""),["dxh", "ix", "snegi", "wiubvu"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
