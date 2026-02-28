# 
sub f {
    my($text, $char) = @_;
    my $count = () = $text =~ /$char/g;
    return $count % 2 != 0;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abababac", "a"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
