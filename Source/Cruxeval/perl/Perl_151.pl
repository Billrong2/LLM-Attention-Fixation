# 
sub f {
    my($text) = @_;
    for my $c (split //, $text) {
        if ($c =~ /\d/) {
            $c = $c eq '0' ? '.' : ($c eq '1' ? '.' : '0');
        }
    }
    return join('', split //, $text) =~ s/\./\0/gr;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("697 this is the ultimate 7 address to attack"),"697 this is the ultimate 7 address to attack")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
