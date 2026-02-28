# 
sub f {
    my($text) = @_;
    my @symbols = ('.', '!', '?');
    foreach my $i (@symbols) {
        if ($text =~ /$i$/) {
            return 1;
        }
    }
    return 0;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(". C."),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
