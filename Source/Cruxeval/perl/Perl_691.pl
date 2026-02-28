# 
sub f {
    my($text, $suffix) = @_;
    if ($suffix ne '' and index($suffix, substr($suffix, -1)) >= 0) {
        return f($text =~ s/[\Q$suffix\E]$//r, substr($suffix, 0, -1));
    } else {
        return $text;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("rpyttc", "cyt"),"rpytt")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
