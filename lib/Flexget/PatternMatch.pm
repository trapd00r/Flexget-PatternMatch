package Flexget::PatternMatch;
require Exporter;
@ISA = qw(Exporter);
#@EXPORT_OK = qw(patternmatch);
our @EXPORT = qw(patternmatch);

use Data::Dumper;
use strict;

our %patterns = (
  'S[0-9]{1}[2-9]{1}E[0-9]{1}[2-9]'  => {
    256   => "\e[38;5;198mNew Episode\e[0m",
    dzen  => "^fg(#ff0000)New Episode^fg()",
    none  => "New Episode",
  },
  'S01E01'                           => {
    256   => "\e[38;5;196mNew Show\e[0m",
    dzen  => "^fg(#ffff00)New Show^fg()",
    none  => "New Show",
  },
  'S0\dE01'                          => {
    256   => "\e[1mSeason Premiere\e[0m",
    dzen  => "^fg(#cccd05)Season Premiere^fg()",
    none  => "Season Premiere",
  },
  'do(c|k?)u(ment.+)?|
  (discovery|history)\.(channel)?|
  national\.geographic|
  colossal\.'                        => {
    256   =>  "\e[38;5;112Documentary\e[0m",
    dzen  =>  "^fg(#87d700)Documentary^fg()",
    none  =>  "Documentary",
  },
  'EPL|WWE|UFC|UEFA|Rugby|La\Liga|
  Superleague|Allsvenskan|
  Formula\.Ford'                     => {
    256   =>  "\e[38;5;144mSport\e[0m",
    dzen  =>  "^fg(#afaf87)Sport^fg()",
    none  =>  "Sport",
  },
  '(?i)swedish|-se-'                 => {
    256   =>  "\e[38;5;122mSwedish\e[0m",
    dzen  =>  "^fg(#87ffd7)Swedish^fg()",
    none  =>  "Swedish",
  },
  '(?i)jay\.leno'                    => {
    256   =>  "\e[38;5;111mTalk Show\e[0m",
    dzen  =>  "^fg(87afff)Talk Show^fg()",
    none  =>  "Talk Show",
  },
  'PsyCZ|MYCEL|UPE|HiEM|PSi|gEm'     => {
    256   =>  "\e[38;5;192mPsychedelic\e[0m",
    dzen  =>  "^fg(#d7ff87)Psychedelic^fg()",
    none  =>  "Psychedelic",
  },
  '.+-(H3X|wAx|CMS|BFHMP3|WHOA|RNS|
  C4|CR|UMT|0MNi)(.+)?|FRAY(.+)?$'   => {
    256   =>  "\e[38;5;094mHip-Hop\e[0m",
    dzen  =>  "^fg(#875f00)Hip-Hop^fg()",
    none  =>  "Hip-Hop",
  },
  'LzY|qF|SRP|NiF'                   => {
    256   =>  "\e[38;5;126mRock\e[0m",
    dzen  =>  "^fg(#af0087)Rock^fg()",
    none  =>  "Rock",
  },
  '-sour$'                           => {
    256   =>  "\e[38;5;166mDnB\e[0m",
    dzen  =>  "^fg(#d75f00)DnB^fg()",
    none  =>  "DnB",
  },
  'VA(-|_-_).+'                      => {
    256   =>  "\e[38;5;049mV/A\e[0m",
    dzen  =>  "^fg(#00ffaf)V/A^fg()",
    none  =>  "V/A",
  },
  '\(?_?-?CDS-?_?\)?'                => {
    256   =>  "\e[38;5;244mSingle\e[0m",
    dzen  =>  "^fg(#808080)Single^fg()",
    none  =>  "Single",
  },
  '\(?_?-?CDM-?_?\)?'                => {
    256   => "\e[38;5;233mMaxi\e[0m",
    dzen  => "^fg(#1c1c1c)Maxi^fg()",
    none  => "Maxi",
  },
  '\(?_?-?CDA-?_?\)?'                => {
    256   => "\e[38;5;222mAlbum\e[0m",
    dzen  => "^fg(#ffd787)Album^fg()",
    none  => "Album",
  },
  '\(?_?-?DAB-?_?\)?'                => {
    256   => "\e[38;5;211mDAB\e[0m",
    dzen  => "^fg(#ff87af)DAB^fg()",
    none  => "DAB",
  },
  '\(?_?-?CABLE-?_?\)?'              => {
    256   => "\e[38;5;191mCable\e[0m",
    dzen  => "^fg(#d7ff5f)Cable\e[0m",
    none  => "Cable",
  },
  '\(?_?-?VLS|Vinyl-?_?\)?'          => {
    256   => "\e[38;5;201mVinyl\e[0m",
    dzen  => "^fg(#ff00ff)Vinyl^fg()",
    none  => "Vinyl",
  },
  '\(?_?-?WEB-?_?\)?'                => {
    256   => "\e[38;5;19mWEB\e[0m",
    dzen  => "^fg(#ffabcd)WEB^fg()",
    none  => "WEB",
  },
  'Live_(on|at|in)'                  => {
    256   => "\e[38;5;181mLive\e[0m",
    dzen  => "^fg(#d7afaf)Live^fg()",
    none  => "Live",
  },
  '-Recycled.+$'                     => {
    256   => "\e[38;5;215Re-release\e[0m",
    dzen  => "^fg(#ffaf5f)Re-release^fg()",
    none  => "Re-release",
  },

  'TALiON|HB|DV8'       => {
    256   => "\e[38;5;41m\e[1mHardstyle\e[0m",
    dzen  => "^fg(#f95504)Hardstyle^fg()",
    none  => "Hardstyle",
  },
);

my(undef,undef,undef,undef,undef,$year) = localtime(time);
$year += 1900;

our %wanted = (
  'Fringe'                     => {
    dzen  => "^fg(#000000)^bg(#ff0000)",
    256   => "\e[48;5;052m\e[1m\e[38;5;196m",
    none  => "",
  },
  'House'                      => {
    dzen  => "^fg(#d5f418)^fg(#ffff00)",
    256   => "\e[38;5;148m",
    none  => "",
  },
  '(?:do(c|k)ument(a|ä)ry?|History\.Channel)'   => {
    dzen  => "^fg(#09b33f)",
    256   => "\e[38;5;197m",
    none  => "",
  },

  'pilot'                      => {
    dzen  => "^fg(#c02d07)",
    256   => "\e[38;5;85m\e[1m",
    none  => "",
  },
  'S01E01'                     => {
    dzen  => "^fg(#d7d75f)",
    256   => "\e[38;5;185m",
    none  => "",
  },
  'hdtv'                       => {
    dzen  => "^fg(#cccdda)",
    256   => "\e[38;5;32m\e[3m",
    none  => "",
  },
  'pdtv'                       => {
    dzen  => "^fg(#dacddd)",
    256   => "\e[38;5;29m\e[3m",
    none  => "",
  },
  'swedish'                    => {
    dzen  => "^fg(#ffff00)",
    256   => "\e[38;5;220m\e[1m",
    none  => "",
  },
  'DIMENSION'                  => {
    dzen  => "^fg(#faeec4)",
    256   => "\e[38;5;240m\e[1m",
    none  => "",
  },
  'C4'                      => {
    dzen  => "^fg(#facddc)",
    256   => "\e[38;5;130m\e[1m",
    none  => "",
  },
  'LOL'                     => {
    dzen  => "^fg(#facddc)",
    256   => "\e[38;5;118m\e[1m",
    none  => "",
  },
  '720p'                    => {
    dzen  => "^fg(#ff0ccd)",
    256   => "\e[38;5;178m\e[1m",
    none  => "",
  },
  'Promo_CD'                => {
    dzen  => "^fg(#dddc26)",
    256   => "\e[38;5;173m",
    none  => "",
  },
  $year                     => {
    dzen  => "^fg(#000000)",
    256   => "\e[1m",
    none  => "",
  },
);

our %end = (
  dzen  => "^fg()^bg()",
  256   => "\e[0m",
  none  => "",
);

sub patternmatch {
  my $esc_style = shift // 'none';
  chomp(my @files = @_);

  my $i = 0;
  my %results;
  # latest release at [0], thank you
  for my $file(reverse(@files)) {
    if($esc_style == 256 or $esc_style eq 'none') {
      $file = sprintf("%70.70s", $file);
    }

    for my $keyword(keys(%wanted)) {
      $file =~ s/($keyword)/$wanted{$keyword}->{$esc_style}$1$end{$esc_style}/gi;
    }

    for my $pattern(keys(%patterns)) {
      if($file =~ /$pattern/x) {
        $results{$i}{$file} = $patterns{$pattern}{$esc_style};
      }
    }
    $i++;
  }
  return(\%results);
}

1;

=head1 NAME

  Flexget::PatternMatch - Retrieve type of media for parsed flexget records

=head1 SYNOPSIS

  use Flexget::PatternMatch;
  use Flexget::Parse;

  my $log = shift // "$ENV{HOME}/.flexget.log";
  open(my $fh, '<', $log) or die("Could not open $log: $!");
  chomp(my @unparsed = <$fh>);
  close($fh);

  # use extended 256 escape sequences for colors
  my $extended = patternmatch('256', flexparse(@content));

  # use dzen2 notation
  my $dzen = patternmatch('dzen', flexparse(@content));

  for my $n(keys(%{$extended})) {
    for my $release(keys(%{$extended->{$n}})) {
      printf("%50.50s | %s\n", $release, $extended->{$n}{$release});
    }
  }

=head1 DESCRIPTION

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

=head2 EXPORTS

patternmatch() is exported by default

=head1 AUTHOR

Written by Magnus Woldrich

=head1 REPORTING BUGS

Report bugs to trapd00r@trapd00r.se

=head1 COPYRIGHT

Copyright (C) 2010 Magnus Woldrich

License GPLv2

=cut
