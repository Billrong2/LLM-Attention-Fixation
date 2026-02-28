# 
sub f {
    my($commands) = @_;
    my %d;
    foreach my $c (@{$commands}) {
        foreach my $key (keys %{$c}) {
            $d{$key} = $c->{$key};
        }
    }
    return \%d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([{"brown" => 2}, {"blue" => 5}, {"bright" => 4}]),{"brown" => 2, "blue" => 5, "bright" => 4})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
