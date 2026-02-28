# 
sub f {
    my($text) = @_;
    my @a = split(' ', $text);
    foreach my $word (@a) {
        if ($word !~ /^\d+$/) {
            return '-';
        }
    }
    return join(" ", @a);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("d khqw whi fwi bbn 41"),"-")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
