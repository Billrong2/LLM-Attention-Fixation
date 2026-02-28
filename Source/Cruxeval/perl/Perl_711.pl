# 
sub f {
    my($text) = @_;
    $text =~ s/\n/\t/g;
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("apples
	
pears
	
bananas"),"apples			pears			bananas")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
