# 
sub f {
    my($txt) = @_;
    my @d;
    foreach my $c (split(//, $txt)) {
        if ($c =~ /\d/) {
            next;
        }
        if ($c =~ /[a-z]/) {
            push @d, uc($c);
        } elsif ($c =~ /[A-Z]/) {
            push @d, lc($c);
        }
    }
    return join('', @d);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("5ll6"),"LL")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
