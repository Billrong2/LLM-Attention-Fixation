# 
sub f {
    my($parts) = @_;
    my %temp_hash = map {@$_} @$parts;
    return [values %temp_hash];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([["u", 1], ["s", 7], ["u", -5]]),[-5, 7])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
