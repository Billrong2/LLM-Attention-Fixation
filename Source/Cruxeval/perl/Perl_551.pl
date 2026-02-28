# 
sub f {
    my($data) = @_;
    my @members;
    foreach my $item (keys %$data) {
        foreach my $member (@{$data->{$item}}) {
            if (!grep { $_ eq $member } @members) {
                push @members, $member;
            }
        }
    }
    return [sort @members];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"inf" => ["a", "b"], "a" => ["inf", "c"], "d" => ["inf"]}),["a", "b", "c", "inf"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
