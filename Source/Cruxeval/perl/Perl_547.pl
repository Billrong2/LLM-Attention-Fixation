# 
sub f {
    my($letters) = @_;
    $letters =~ s/^[\., !\?\*]|[\., !\?\*]$//g;
    return join("....", split(/ /, $letters));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("h,e,l,l,o,wo,r,ld,"),"h,e,l,l,o,wo,r,ld")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
