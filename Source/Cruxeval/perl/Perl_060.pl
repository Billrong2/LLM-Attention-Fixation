# 
sub f {
    my($doc) = @_;
    my @chars = split(//, $doc);
    foreach my $x (@chars) {
        if ($x =~ /[a-zA-Z]/) {
            return uc $x;
        }
    }
    return '-';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("raruwa"),"R")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
