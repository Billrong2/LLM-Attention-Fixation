# 
sub f {
    my($d, $get_ary) = @_;
    my @result;
    foreach my $key (@$get_ary) {
        push @result, exists $d->{$key} ? $d->{$key} : undef;
    }
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({3 => "swims like a bull"}, [3, 2, 5]),["swims like a bull", undef, undef])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
