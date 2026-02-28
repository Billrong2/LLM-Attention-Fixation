# 
sub f {
    my($text) = @_;
    my @t = split('', $text);
    splice(@t, int(scalar(@t) / 2), 1);
    push @t, lc $text;
    return join(':', @t);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Rjug nzufE"),"R:j:u:g: :z:u:f:E:rjug nzufe")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
