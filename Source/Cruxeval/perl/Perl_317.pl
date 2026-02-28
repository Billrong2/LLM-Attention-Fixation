# 
sub f {
    my($text, $a, $b) = @_;
    $text =~ s/$a/$b/g;
    return $text =~ s/$b/$a/gr;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(" vup a zwwo oihee amuwuuw! ", "a", "u")," vap a zwwo oihee amawaaw! ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
