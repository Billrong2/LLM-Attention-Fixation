# 
sub f {
    my($text, $use) = @_;
    $text =~ s/$use//g;
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Chris requires a ride to the airport on Friday.", "a"),"Chris requires  ride to the irport on Fridy.")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
