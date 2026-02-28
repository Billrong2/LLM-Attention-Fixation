# 
sub f {
    my($text, $new_value, $index) = @_;
    my $key = $text;
    my $old_char = substr($text, $index, 1);
    my $new_char = $new_value;
    $key =~ s/\Q$old_char/$new_char/;
    return $key;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("spain", "b", 4),"spaib")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
