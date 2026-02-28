# 
sub f {
    my($text) = @_;
    my $new_text = '';
    foreach my $ch (split('', lc($text =~ s/^\s+|\s+$//gr))) {
        if ($ch =~ /^\d$/ or $ch =~ /^[ÄäÏïÖöÜü]$/) {
            $new_text .= $ch;
        }
    }
    return $new_text;
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
