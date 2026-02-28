# 
sub f {
    my($array, $value) = @_;
    my @array = reverse(@$array);
    pop @array;
    my @odd;
    while (@array) {
        my %tmp;
        $tmp{pop @array} = $value;
        push @odd, \%tmp;
    }
    my %result;
    while (@odd) {
        my %tmp = %{pop @odd};
        %result = (%result, %tmp);
    }
    return \%result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["23"], 123),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
