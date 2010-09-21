package Flexget::PatternMatch;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(patternmatch);

use Data::Dumper;
use strict;

our %patterns = (
  'S[0-9]{1}[2-9]{1}E[0-9]{1}[2-9]'  => {
    ansi  => "\e[38;5;198mNew Episode\e[0m",
    dzen  => "^fg(#ff0000)New Episode^fg()",
  },
  'S01E01'                           => {
    ansi  => "\e[38;5;196mNew Show\e[0m",
    dzen  => "^fg(#ffff00)New Show^fg()",
  },
  'S0\dE01'                          => {
    ansi  => "\e[38;5;196mSeason Premiere\e[0m",
    dzen  => "^fg(#cccd05)Season Premiere^fg()",
  },
  'do(c|k?)u(ment.+)?|
  (discovery|history)\.(channel)?|
  national\.geographic|
  colossal\.'                        => {
    ansi  =>  "\e[38;5;112Documentary\e[0m",
    dzen  =>  "^fg(#87d700)Documentary^fg()",
  },
  'EPL|WWE|UFC|UEFA|Rugby|La\Liga|
  Superleague|Allsvenskan|
  Formula\.Ford'                     => {
    ansi  =>  "\e[38;5;144mSport\e[0m",
    dzen  =>  "^fg(#afaf87)Sport^fg()",
  },
  '(?i)swedish|-se-'                 => {
    ansi  =>  "\e[38;5;122mSwedish\e[0m",
    dzen  =>  "^fg(#87ffd7)Swedish^fg()",
  },
  '(?i)jay\.leno'                    => {
    ansi  =>  "\e[38;5;111Talk Show\e[0m",
    dzen  =>  "^fg(87afff)Talk Show^fg()",
  },
  'PsyCZ|MYCEL|UPE|HiEM|PSi|gEm'     => {
    ansi  =>  "\e[38;5;192mPsychedelic\e[0m",
    dzen  =>  "^fg(#d7ff87)Psychedelic^fg()",
  },
  '.+-(H3X|wAx|CMS|BFHMP3|WHOA|RNS|
  C4|CR|UMT|0MNi)(.+)?|FRAY(.+)?$'   => {
    ansi  =>  "\e[38;5;094mHip-Hop\e[0m",
    dzen  =>  "^fg(#875f00)Hip-Hop^fg()",
  },
  'LzY|qF|SRP|NiF'                   => {
    ansi  =>  "\e[38;5;126mRock\e[0m",
    dzen  =>  "^fg(#af0087)Rock^fg()",
  },
  '-sour$'                           => {
    ansi  =>  "\e[38;5;166mDnB\e[0m",
    dzen  =>  "^fg(#d75f00)DnB^fg()",
  },
  'VA(-|_-_).+'                      => {
    ansi  =>  "\e[38;5;049mV/A\e[0m",
    dzen  =>  "^fg(#00ffaf)V/A^fg()",
  },
  '\(?_?-?CDS-?_?\)?'                => {
    ansi  =>  "\e[38;5;244mSingle\e[0m",
    dzen  =>  "^fg(#808080)Single^fg()",
  },
  '\(?_?-?CDM-?_?\)?'                => {
    ansi  => "\e[38;5;233mMaxi\e[0m",
    dzen  => "^fg(#1c1c1c)Maxi^fg()",
  },
  '\(?_?-?CDA-?_?\)?'                => {
    ansi  => "\e[38;5;222mAlbum\e[0m",
    dzen  => "^fg(#ffd787)Album^fg()",
  },
  '\(?_?-?DAB-?_?\)?'                => {
    ansi  => "\e[38;5;211mDAB\e[0m",
    dzen  => "^fg(#ff87af)DAB^fg()",
  },
  '\(?_?-?CABLE-?_?\)?'              => {
    ansi  => "\e[38;5;191mCable\e[0m",
    dzen  => "^fg(#d7ff5f)Cable\e[0m",
  },
  '\(?_?-?VLS|Vinyl-?_?\)?'          => {
    ansi  => "\e[38;5;201mVinyl\e[0m",
    dzen  => "^fg(#ff00ff)Vinyl^fg()",
  },
  '\(?_?-?WEB-?_?\)?'                => {
    ansi  => "\e[38;5;19mWEB\e[0m",
    dzen  => "^fg(#ffabcd)WEB^fg()",
  },
  'Live_(on|at|in)'                  => {
    ansi  => "\e[38;5;181mLive\e[0m",
    dzen  => "^fg(#d7afaf)Live^fg()",
  },
  '-Recycled.+$'                     => {
    ansi  => "\e[38;5;215Re-release\e[0m",
    dzen  => "^fg(#ffaf5f)Re-release^fg()",
  },

  'TALiON|HB|DV8'       => {
    ansi  => "\e[38;5;41m\e[1mHardstyle\e[0m",
    dzen  => "^fg(#f95504)Hardstyle^fg()",
  },
);

sub patternmatch {
  my $esc_style = shift;
  chomp(my @files = @_);

  my %results;
  my $i = 0;
  for my $file( @files ) {
    for my $pattern(keys(%patterns)) {
      if($file =~ m/$pattern/x) {
        $results{$i}{$file} = $patterns{$pattern}{$esc_style};
      }
    }
    $i++;
  }
  return(\%results);
}

