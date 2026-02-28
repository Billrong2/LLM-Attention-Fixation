# 
sub f {
    my($letters, $maxsplit) = @_;
    my @split_letters = split(' ', $letters);
    return join('', @split_letters[-$maxsplit..-1]);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("elrts,SS ee", 6),"elrts,SSee")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
