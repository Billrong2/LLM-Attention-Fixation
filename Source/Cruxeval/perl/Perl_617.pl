# 
sub f {
    my($text) = @_;
    if ($text =~ m/^[\x00-\x7F]*$/s) {
        return 'ascii';
    } else {
        return 'non ascii';
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("<<<<"),"ascii")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
