# 
sub f {
    my($text) = @_;
    my @new_text = split(//, $text);
    for (my $i = 0; $i < scalar @new_text; $i++) {
        my $character = $new_text[$i];
        my $new_character = lc $character ^ uc $character ^ $character;
        $new_text[$i] = $new_character;
    }
    return join('', @new_text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("dst vavf n dmv dfvm gamcu dgcvb."),"DST VAVF N DMV DFVM GAMCU DGCVB.")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
