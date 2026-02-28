# 
sub f {
    my($text, $sep, $maxsplit) = @_;
    my @splitted = reverse(split(/$sep/, $text, $maxsplit + 1));
    my $length = @splitted;
    @splitted = @splitted[0..($length / 2)] if $length % 2 == 0;
    @splitted = @splitted[0..(($length - 1) / 2)];
    return join($sep, @splitted);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ertubwi", "p", 5),"ertubwi")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
