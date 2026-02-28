# 
sub f {
    my($text) = @_;
    my %d;
    my @chars = split("", $text);
    foreach my $char (@chars) {
        $char = lc $char;
        $d{$char} = exists $d{$char} ? $d{$char} + 1 : 1;
    }
    my @sorted_keys = sort { $d{$a} <=> $d{$b} } keys %d;
    my @result = map { $d{$_} } @sorted_keys;
    return @result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("x--y-z-5-C"),[1, 1, 1, 1, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
