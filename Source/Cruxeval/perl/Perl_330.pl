# 
sub f {
    my($text) = @_;
    my @ans;
    foreach my $char (split('', $text)) {
        if ($char =~ /\d/) {
            push @ans, $char;
        } else {
            push @ans, ' ';
        }
    }
    return join('', @ans);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("m4n2o")," 4 2 ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
