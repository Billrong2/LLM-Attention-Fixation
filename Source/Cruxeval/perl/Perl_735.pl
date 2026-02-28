# 
sub f {
    my($sentence) = @_;
    if ($sentence eq '') {
        return '';
    }
    $sentence =~ s/\(//g;
    $sentence =~ s/\)//g;
    $sentence =~ s/^(.)|\s+(.)/\U$1\E\L$2/g;
    return $sentence;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("(A (b B))"),"Abb")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
