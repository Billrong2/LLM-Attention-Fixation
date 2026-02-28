# 
sub f {
    my($dict1, $dict2) = @_;
    my %result = %{$dict1};
    foreach my $key (keys %{$dict2}) {
        $result{$key} = $dict2->{$key};
    }
    return \%result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"disface" => 9, "cam" => 7}, {"mforce" => 5}),{"disface" => 9, "cam" => 7, "mforce" => 5})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
