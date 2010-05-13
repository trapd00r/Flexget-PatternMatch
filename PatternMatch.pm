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
    Formula\.Ford'                      => "\033[38;5;144mSport",
  'swedish'                             => "\033[38;5;122mSwedish",

  'PsyCZ|MYCEL|UPE|HiEM|PSi'            => "\033[38;5;192mPsychedelic",
  '.+-(H3X|wAx|CMS|BFHMP3|WHOA|RNS|
    C4|UMT|0MNi(.+)?|FRAY(.+)?)$'       => "\033[38;5;94mHip-Hop",
  'LzY|qF|SRP|NiF'                      => "\033[38;5;126mRock/Metal",
  'TALiON|HB'                           => "\033[38;5;41mHardstyle",
  'VA(-|_-_).+'                         => "\033[38;5;49mVarious",
  '.+(-WEB-)'                           => "\033[38;5;250mWEB",
  '.+(-CDS-)'                           => "\033[38;5;244mCDS",
  '.+(-CDM-)'                           => "\033[38;5;233mCDM",
  '.+(-CDA-)'                           => "\033[38;5;222mCDA",
  '.+(-DAB-)'                           => "\033[38;5;211mDAB",
  '.+(-VLS-)'                           => "\033[38;5;201mVLS",
  '.+(-CABLE-)'                         => "\033[38;5;191mCABLE",
  'Live_(on|at|in)'                     => "\033[38;5;181mLIVE",


);
sub patternmatch {
  my @files = @_;
  my $nocolor = "\033[0m";
  foreach my $file(@files) {
    chomp($file);
    $file = sprintf("%60s", $file);
    $file = sprintf("%.60s", $file);
    for my $pattern(keys(%patterns)) {
      if($file =~ m/$pattern/ix) {
        $file = $file.' '.$patterns{$pattern}.$nocolor;
      }
    }
  }
  return @files;
}

