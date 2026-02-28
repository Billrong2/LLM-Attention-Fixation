# 
sub f {
    my($text) = @_;
    my @lines = split(/\n/, $text);
    return scalar @lines;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ncdsdfdaaa0a1cdscsk*XFd"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
