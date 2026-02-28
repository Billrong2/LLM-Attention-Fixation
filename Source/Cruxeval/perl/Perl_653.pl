# 
sub f {
    my($text, $letter) = @_;
    my @alphabet = ('a'..'z');
    my $t = $text;
    for my $alph (@alphabet) {
        $t =~ s/$alph//g;
    }
    return scalar(split(/$letter/, $t));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("c, c, c ,c, c", "c"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
