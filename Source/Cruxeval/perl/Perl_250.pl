# 
sub f {
    my($text) = @_;
    my $count = length($text);
    for my $i (-$count+1..-1) {
        $text = $text . substr($text, $i, 1);
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("wlace A"),"wlace Alc l  ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
