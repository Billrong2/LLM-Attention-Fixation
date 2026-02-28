# 
sub f {
    my($text, $suffix) = @_;
    my $output = $text;
    while ($text =~ /$suffix\z/) {
        $output = substr($text, 0, length($text) - length($suffix));
        $text = $output;
    }
    return $output;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("!klcd!ma:ri", "!"),"!klcd!ma:ri")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
