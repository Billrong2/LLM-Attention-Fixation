# 
sub f {
    my($array) = @_;
    my @result;
    foreach my $elem (@$array) {
        if ($elem =~ m/^[[:ascii:]]+$/ || (ref($elem) eq 'SCALAR' && $elem >= 0 && abs($elem) =~ m/^[[:ascii:]]+$/)) {
            push @result, $elem;
        }
    }
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["a", "b", "c"]),["a", "b", "c"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
