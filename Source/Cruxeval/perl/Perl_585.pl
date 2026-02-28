# 
sub f {
    my($text) = @_;
    my $count = () = $text =~ /$text/g;
    my @ls = split('', $text);
    for (my $i = 0; $i < $count; $i++) {
        shift @ls;
    }
    return join('', @ls);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(";,,,?"),",,,?")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
