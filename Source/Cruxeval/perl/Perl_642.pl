# 
sub f {
    my($text) = @_;
    my $i = 0;
    while ($i < length($text) && substr($text, $i, 1) =~ /\s/) {
        $i++;
    }
    if ($i == length($text)) {
        return 'space';
    }
    return 'no';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("     "),"space")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
