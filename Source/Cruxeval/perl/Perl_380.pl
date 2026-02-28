# 
sub f {
    my($text, $delimiter) = @_;
    $text =~ /(.*)$delimiter(.*)/;
    return "$1$2";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("xxjarczx", "x"),"xxjarcz")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
