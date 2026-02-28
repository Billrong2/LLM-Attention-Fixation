# 
sub f {
    my($text) = @_;
    my @a = ('');
    my $b = '';
    foreach my $i (split(//, $text)) {
        if ($i !~ /\s/) {
            push @a, $b;
            $b = '';
        } else {
            $b .= $i;
        }
    }
    return scalar(@a);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("       "),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
