# 
sub f {
    my($s) = @_;
    $s =~ s/\(/\[/g;
    $s =~ s/\)/\]/g;
    return $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("(ac)"),"[ac]")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
