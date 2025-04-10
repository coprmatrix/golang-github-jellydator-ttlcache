s~%global\s+goipath\s+(.*)/(.*)~%global goihead \2\n%global goipath2 \1/%{goihead}~g;

my $text = "%{lua: print(rpm.expand('%version'):gsub('%..*', ''))}";

s~(Version:)\s*([^0-9\.]*)([0-9\.]*)([^\s]*)\s*~\1  \3\n%define oldver \2\3\4\n%define goipath %{goipath2}/v$text~g;
s~(^%gometa.*)~%{?!tag:%{?!commit:%global tag v%{oldver}}}\n\1\n~g;

s~%gocheck~~g;
s~Source:.*~%define scommit %{?commit}%{?!commit:v%{version}}\n%define stag %{?tag}%{?!tag:%scommit}\nSource: https://%{goipath2}/archive/%{stag}/%{goihead}-%{stag}.tar.gz~g;
