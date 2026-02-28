# 
sub f {
    my($text) = @_;
    if ($text && uc($text) eq $text) {
        my $cs = uc(join("", 'A'..'Z'));
        my $trans = join("", 'a'..'z');
        $text =~ tr/$cs/$trans/;
        return $text;
    } else {
        return lc(substr($text, 0, 3));
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n"),"mty")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
