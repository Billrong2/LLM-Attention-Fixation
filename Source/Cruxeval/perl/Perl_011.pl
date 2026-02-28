# 
sub f {
    my($a, $b) = @_;
    foreach my $key (keys %$b) {
        my $value = $b->{$key};
        if (not exists $a->{$key}) {
            $a->{$key} = [$value];
        } else {
            push @{$a->{$key}}, $value;
        }
    }
    return $a;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}, {"foo" => "bar"}),{"foo" => ["bar"]})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
