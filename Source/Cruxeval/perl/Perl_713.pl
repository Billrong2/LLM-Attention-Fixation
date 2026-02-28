# 
sub f {
    my($text, $char) = @_;
    if (index($text, $char) != -1) {
        my @text_arr = grep { $_ } map { s/^\s+|\s+$//g; $_ } split /$char/, $text;
        if (@text_arr > 1) {
            return 1;
        }
    }
    return 0;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("only one line", " "),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
