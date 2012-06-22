use strict;
use warnings;
use Irssi;

use AnyEvent::HTTP;
use Growl::GNTP;
use HTTP::Request::Common;
use Try::Tiny;

our $VERSION = '0.1';

our %IRSSI = (
    name        => 'hilight_notify',
    description => 'notify hilight message to Growl via GNTP or IM via im.kayac.com api',
    authors     => 'sugyan',
);

sub sig_printtext {
    my ($dest, $text, $stripped) = @_;

    return unless ($dest->{level} & MSGLEVEL_HILIGHT);

    my $message = sprintf('%s %s', $dest->{target}, $stripped);
    try {
        my $growl = Growl::GNTP->new(AppName => 'IRC irssi');
        $growl->register([{
            Name => 'hilight',
        }]);
        $growl->notify(
            Event => 'hilight',
            Title => 'irssi',
            Message => $message,
        );
    } catch {
        my $user = Irssi::settings_get_str('im_kayac_com_username') or return;
        my $req = POST "http://im.kayac.com/api/post/$user", [ message => $message ];
        my %headers = map { $_ => $req->header($_), } $req->headers->header_field_names;
        my $r;
        $r = http_post $req->uri, $req->content, headers => \%headers, sub {
            undef $r;
        };
    };
}

Irssi::signal_add('print text' => \&sig_printtext);
Irssi::settings_add_str('im_kayac_com', 'im_kayac_com_username', '');
