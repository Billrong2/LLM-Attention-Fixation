# 
sub f {
    my($text, $tabstop) = @_;
    $text =~ s/\n/_____/g;
    $text =~ s/\t/' ' x $tabstop/ge;
    $text =~ s/_____/\\n/g;
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("odes	code	well", 2),"odes  code  well")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
