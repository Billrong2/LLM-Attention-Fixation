# 
sub f {
    my($array, $elem) = @_;
    my %result = %{$array};
    while (%result) {
        my ($key, $value) = each %result;
        if ($elem eq $key || $elem eq $value) {
            %result = (%result, %{$array});
        }
        delete $result{$key};
    }
    return \%result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}, 1),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
