# 
sub f {
    my($text, $to_place) = @_;
    my $after_place = substr($text, 0, index($text, $to_place) + 1);
    my $before_place = substr($text, index($text, $to_place) + 1);
    return $after_place . $before_place;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("some text", "some"),"some text")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
