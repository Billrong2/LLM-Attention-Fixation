# 
sub f {
    my($text) = @_;
    my @texts = split(' ', $text);
    if (@texts) {
        my @xtexts = grep { /\p{ascii}/ && $_ ne 'nada' && $_ ne '0' } @texts;
        return (sort { length($b) <=> length($a) } @xtexts)[0] || 'nada';
    }
    return 'nada';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(""),"nada")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
