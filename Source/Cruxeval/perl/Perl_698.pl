# 
sub f {
    my($text) = @_;
    $text =~ s/\)//g;
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("(((((((((((d))))))))).))))((((("),"(((((((((((d.(((((")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
