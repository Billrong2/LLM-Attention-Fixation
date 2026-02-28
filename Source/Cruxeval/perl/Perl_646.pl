# 
sub f {
    my($text, $count) = @_;
    for (my $i = 0; $i < $count; $i++) {
        $text = reverse($text);
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("aBc, ,SzY", 2),"aBc, ,SzY")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
