# 
sub f {
    my($text) = @_;
    return join(' ', map {my $s = $_; $s =~ s/^\s+//; $s} split(' ', $text));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("pvtso"),"pvtso")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
