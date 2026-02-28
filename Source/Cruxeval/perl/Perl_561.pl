# 
sub f {
    my($text, $digit) = @_;
    my $count = () = $text =~ /$digit/g;
    return int($digit) * $count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("7Ljnw4Lj", "7"),7)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
