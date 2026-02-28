# 
sub f {
    my($single_digit) = @_;
    my @result;
    for my $c (1..10) {
        if ($c != $single_digit) {
            push @result, $c;
        }
    }
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(5),[1, 2, 3, 4, 6, 7, 8, 9, 10])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
