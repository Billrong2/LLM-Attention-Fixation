# 
sub f {
    my($dic) = @_;
    my %dic_op = %$dic;
    foreach my $key (keys %dic_op) {
        $dic_op{$key} = $dic_op{$key} * $dic_op{$key};
    }
    return \%dic_op;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({1 => 1, 2 => 2, 3 => 3}),{1 => 1, 2 => 4, 3 => 9})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
