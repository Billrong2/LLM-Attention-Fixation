# 
sub f {
    my($s, $sep) = @_;
    $s .= $sep;
    return substr($s, 0, rindex($s, $sep));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("234dsfssdfs333324314", "s"),"234dsfssdfs333324314")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
