# 
sub f {
    my($text) = @_;
    $text =~ s/(\w+)/\u\L$1/g;
    $text =~ s/Io/io/g;
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Fu,ux zfujijabji pfu."),"Fu,Ux Zfujijabji Pfu.")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
