# 
sub f {
    my($text) = @_;
    my($topic, $sep, $problem) = ($text =~ /^(.*)(\|)(.*)$/);
    if (defined $sep) {
        $problem = $topic;
        $problem =~ s/u/p/g;
    } else {
        $sep = '';
        $problem = $text;
    }
    return ($topic, $problem);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("|xduaisf"),["", "xduaisf"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
