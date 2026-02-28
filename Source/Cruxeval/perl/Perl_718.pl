# 
sub f {
    my($text) = @_;
    my $t = $text;
    foreach my $i (split //, $text) {
        $text =~ s/\Q$i//g;
    }
    return length($text) . $t;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ThisIsSoAtrocious"),"0ThisIsSoAtrocious")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
