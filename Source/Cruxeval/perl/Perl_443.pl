# 
sub f {
    my($text) = @_;
    foreach my $space (split //, $text) {
        if ($space eq ' ') {
            $text =~ s/^\s+//;
        } else {
            $text =~ s/cd/$space/g;
        }
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("lorem ipsum"),"lorem ipsum")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
