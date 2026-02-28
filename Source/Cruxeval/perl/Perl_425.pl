# 
sub f {
    my($a) = @_;
    $a =~ s/\//:/g;
    my @z = $a =~ /(.*?)(:)(.*)/;
    return [$z[0], $z[1], $z[2]];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("/CL44     "),["", ":", "CL44     "])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
