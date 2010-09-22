# NAME

  Flexget::PatternMatch - Retrieve type of media for parsed flexget records

# SYNOPSIS

    use Flexget::PatternMatch;
    use Flexget::Parse;

    my $log = shift // "$ENV{HOME}/.flexget.log";
    open(my $fh, '<', $log) or die("Could not open $log: $!");
    chomp(my @unparsed = <$fh>);
    close($fh);

    # use extended ANSI escape sequences for colors
    my $ansi = patternmatch('ansi', flexparse(@content));

    # use dzen2 notation
    my $dzen = patternmatch('dzen', flexparse(@content));

    for my $n(keys(%{$ansi})) {
      for my $release(keys(%{$ansi->{$n}})) {
        printf("%50.50s | %s\n", $release, $ansi->{$n}{$release});
      }
    }

# DESCRIPTION

Flexget::PatternMatch takes a list of filenames and returns a hash of hashes
that looks like this:

    # dzen2 notation
    '2' => {
      'Laleh-Prinsessor-SE-2006-LzY' => '^fg(#af0087)Rock^fg()'
    },

    # Extended terminal color escape sequences
    '9' => {
      'Prison.Break.S01E01-FOOBAR'   => "\e[38;5;160mNew Show\e[0m"
    },

## EXPORTS

patternmatch() is exported by default

# AUTHOR

Written by Magnus Woldrich

# REPORTING BUGS

Report bugs to trapd00r@trapd00r.se

# COPYRIGHT

Copyright (C) 2010 Magnus Woldrich

License GPLv2
