# 
sub f {
    my($text, $char) = @_;
    my $count =()= $text =~ /$char$char/g;
    return substr($text, $count);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("vzzv2sg", "z"),"zzv2sg")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
