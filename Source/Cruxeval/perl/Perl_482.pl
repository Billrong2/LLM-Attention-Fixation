# 
sub f {
    my($text) = @_;
    $text =~ s/\\\"/\"/g;
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Because it intrigues them"),"Because it intrigues them")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
