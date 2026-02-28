# 
sub f {
    my($text) = @_;
    my @words = split(' ', $text);
    foreach my $item (@words) {
        $text =~ s/-\Q$item\E/ /g;
        $text =~ s/\Q$item\E-/ /g;
    }
    $text =~ s/^-+|-+$//g;
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("-stew---corn-and-beans-in soup-.-"),"stew---corn-and-beans-in soup-.")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
