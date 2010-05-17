package Flexget::PatternMatch;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(patternmatch);

use Data::Dumper;

our %patterns = (
  'S[0-9]{2}E[0-9]{2}'                  => "\033[38;5;198mNew Episode",
  'S01E01'                              => "\033[38;5;196mNew Show",
  'do(c|k?)u(ment.+)?|
    (discovery|history)\.(channel)?|
    national\.geographic|
    colossal\..+'                       => "\033[38;5;112mDocumentary",
  'EPL|WWE|UFC|UEFA|Rugby|La\.Liga|
    Superleague|Allsvenskan|
    Formula\.(Ford|[0-9]{4})'           => "\033[38;5;144mSport",
  '(?i)swedish|-se-'                    => "\033[38;5;122mSwedish",
  '(?i)jay\.leno'                       => "\033[38;5;111mTalk Show",

  'PsyCZ|MYCEL|UPE|HiEM|PSi|gEm'        => "\033[38;5;192mPsychedelic",
  '.+-(H3X|wAx|CMS|BFHMP3|WHOA|RNS|
    C4|CR|UMT|0MNi(.+)?|FRAY(.+)?)$'    => "\033[38;5;94mHip-Hop",
  'LzY|qF|SRP|NiF'                      => "\033[38;5;126mRock/Metal",
  'TALiON|HB|DV8'                       => "\033[38;5;41mHardstyle",
  '-sour$'                              => "\033[38;5;166mDnB",
  'VA(-|_-_).+'                         => "\033[38;5;49mVarious",
  '\(?_?-?WEB-?_?\)?'                   => "\033[38;5;250mWEB",
  '\(?_?-?CDS-?_?\)?'                   => "\033[38;5;244mCDS",
  '\(?_?-?CDM-?_?\)?'                   => "\033[38;5;233mCDM",
  '\(?_?-?CDA-?_?\)?'                   => "\033[38;5;222mCDA",
  '\(?_?-?DAB-?_?\)?'                   => "\033[38;5;211mDAB",
  '\(?_?-?VLS|Vinyl-?_?\)?'             => "\033[38;5;201mVLS",
  '\(?_?-?CABLE-?_?\)?'                 => "\033[38;5;191mCABLE",
  'Live_(on|at|in)'                     => "\033[38;5;181mLIVE",
  '-Recycled.+$'                        => "\033[38;5;215mRe-release",

);
sub patternmatch {
  my @files = @_;
  my $nocolor = "\033[0m";
  foreach my $file(@files) {
    chomp($file);
    $file = sprintf("%60s", $file);
    $file = sprintf("%.60s", $file);
    for my $pattern(keys(%patterns)) {
      if($file =~ m/$pattern/x) {
        $file = $file.' '.$patterns{$pattern}.$nocolor;
      }
    }
  }
  return @files;
}

