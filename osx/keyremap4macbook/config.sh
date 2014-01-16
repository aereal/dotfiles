#!/bin/sh

cli=/Applications/KeyRemap4MacBook.app/Contents/Applications/KeyRemap4MacBook_cli.app/Contents/MacOS/KeyRemap4MacBook_cli

$cli set org.aereal.sequel-pro.remap-c-h-to-delete 1
/bin/echo -n .
$cli set repeat.initial_wait 200
/bin/echo -n .
$cli set org.aereal.limechat.move-to-previous-unread-channel 1
/bin/echo -n .
$cli set remap.space2shiftL_space_keyrepeat 1
/bin/echo -n .
$cli set org.aereal.limechat.move-down-channel 1
/bin/echo -n .
$cli set option.emacsmode_controlM 1
/bin/echo -n .
$cli set repeat.wait 35
/bin/echo -n .
$cli set org.aereal.limechat.move-up-channel 1
/bin/echo -n .
$cli set remap.swapcolons 1
/bin/echo -n .
$cli set org.aereal.limechat.move-to-next-unread-channel 1
/bin/echo -n .
/bin/echo
