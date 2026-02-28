# 
sub f {
    my($text, $chars) = @_;
    if ($chars) {
        $text =~ s/[$chars]*$//;
    } else {
        $text =~ s/[ ]*$//;
    }
    if ($text eq '') {
        return '-';
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("new-medium-performing-application - XQuery 2.2", "0123456789-"),"new-medium-performing-application - XQuery 2.")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
