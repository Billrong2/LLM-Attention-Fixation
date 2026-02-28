# 
sub f {
    my($text) = @_;
    my $ans = '';
    while ($text ne '') {
        my ($x, $sep, $rest) = split(/\(/, $text, 2);
        $ans = $x . $sep =~ s/\(/|/rg . $ans;
        $ans = $ans . substr($rest, 0, 1) . $ans;
        $text = substr($rest, 1);
    }
    return $ans;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(""),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
