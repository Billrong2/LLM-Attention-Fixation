# 
sub f {
    my($dictionary) = @_;
    my %a = %$dictionary;
    foreach my $key (keys %a) {
        if ($key % 2 != 0) {
            delete $a{$key};
            $a{'$' . $key} = $a{$key};
        }
    }
    return \%a;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
