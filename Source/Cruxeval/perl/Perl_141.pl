# 
sub f {
    my($li) = @_;
    my @result;
    foreach my $i (@$li) {
        push @result, scalar(grep { $_ eq $i } @$li);
    }
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["k", "x", "c", "x", "x", "b", "l", "f", "r", "n", "g"]),[1, 3, 1, 3, 3, 1, 1, 1, 1, 1, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
