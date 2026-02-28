# 
sub f {
    my($text, $search_chars, $replace_chars) = @_;

    my @search_chars = split //, $search_chars;
    my @replace_chars = split //, $replace_chars;

    my %trans_table = map { $search_chars[$_] => $replace_chars[$_] } 0..$#search_chars;

    my @text = split //, $text;
    for my $i (0..$#text) {
        if (exists $trans_table{$text[$i]}) {
            $text[$i] = $trans_table{$text[$i]};
        }
    }

    my $result = join '', @text;
    return $result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("mmm34mIm", "mm3", ",po"),"pppo4pIp")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
