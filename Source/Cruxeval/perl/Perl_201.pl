# 
sub f {
    my($text) = @_;
    my @chars;
    foreach my $c (split(//, $text)) {
        if ($c =~ /\d/) {
            push @chars, $c;
        }
    }
    return join('', reverse @chars);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("--4yrw 251-//4 6p"),"641524")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
