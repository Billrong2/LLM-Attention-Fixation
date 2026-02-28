# 
sub f {
    my($text) = @_;
    if ($text eq '') {
        return 0;
    }
    my $first_char = substr($text, 0, 1);
    if ($first_char =~ /^\d/) {
        return 0;
    }
    for my $last_char (split //, $text) {
        if ($last_char ne '_' && $last_char !~ /\w/) {
            return 0;
        }
    }
    return 1;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("meet"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
