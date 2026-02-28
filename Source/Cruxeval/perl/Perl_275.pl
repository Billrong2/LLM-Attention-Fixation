# 
sub f {
    my($dic) = @_;
    my %dic2 = reverse %$dic;
    return \%dic2;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({-1 => "a", 0 => "b", 1 => "c"}),{"a" => -1, "b" => 0, "c" => 1})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
