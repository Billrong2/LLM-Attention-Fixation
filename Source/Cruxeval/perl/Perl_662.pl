# 
sub f {
    my($values) = @_;
    my @names = ('Pete', 'Linda', 'Angela');
    push @names, @{$values};
    @names = sort @names;
    return \@names;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["Dan", "Joe", "Dusty"]),["Angela", "Dan", "Dusty", "Joe", "Linda", "Pete"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
