# 
sub f {
    my($n) = @_;
    my $length = length($n) + 2;
    my @revn = split(//, $n);
    my $result = join('', @revn);
    @revn = ();
    return $result . ('!' x $length);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("iq"),"iq!!!!")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
