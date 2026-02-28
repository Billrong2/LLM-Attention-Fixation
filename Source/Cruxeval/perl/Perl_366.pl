# 
sub f {
    my($string) = @_;
    my $tmp = lc($string);
    foreach my $char (split //, lc($string)) {
        if (index($tmp, $char) != -1) {
            $tmp =~ s/\Q$char//;
        }
    }
    return $tmp;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("[ Hello ]+ Hello, World!!_ Hi"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
