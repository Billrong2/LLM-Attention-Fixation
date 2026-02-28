# 
sub f {
    my($s) = @_;
    return uc($s);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Jaafodsfa SOdofj AoaFjIs  JAFasIdfSa1"),"JAAFODSFA SODOFJ AOAFJIS  JAFASIDFSA1")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
