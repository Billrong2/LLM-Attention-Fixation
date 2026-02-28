# 
sub f {
    my($dic) = @_;
    my @pairs = sort { $a->[0] cmp $b->[0] } map { [ $_ => $dic->{$_} ] } keys %$dic;
    return \@pairs;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"b" => 1, "a" => 2}),[["a", 2], ["b", 1]])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
