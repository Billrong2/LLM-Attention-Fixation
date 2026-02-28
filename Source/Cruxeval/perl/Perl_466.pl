# 
sub f {
    my($text) = @_;
    my $length = length($text);
    my $index = 0;
    while ($index < $length && substr($text, $index, 1) =~ /\s/) {
        $index++;
    }
    return substr($text, $index, 5);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("-----	
	th
-----"),"-----")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
