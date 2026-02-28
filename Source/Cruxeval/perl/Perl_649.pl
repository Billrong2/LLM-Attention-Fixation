# 
sub f {
    my($text, $tabsize) = @_;
    my @lines = split("\n", $text);
    my @expanded_lines = map { $_ =~ s/\t/ /g; $_ } @lines;
    return join("\n", @expanded_lines);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("	f9
	ldf9
	adf9!
	f9?", 1)," f9
 ldf9
 adf9!
 f9?")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
