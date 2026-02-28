# 
sub f {
    my($dic) = @_;
    my %d;
    while (my ($key, $value) = each %$dic) {
        $d{$key} = delete $dic->{$key};
    }
    return \%d;
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
