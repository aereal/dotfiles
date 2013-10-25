S.cfga
  defaultToCurrentScreen: true
  checkDefaultsOnLoad: true
  modalEscapeKey: 'esc'

VI_LIKE_WINDOW_PLACEMENT_PREFIX_KEY = [
  'delete'
  'ctrl'
  'cmd'
].join(',')

vi = (key) -> [key, VI_LIKE_WINDOW_PLACEMENT_PREFIX_KEY, 'toggle'].join(':')

viLikeWindowPlacements =
  h: S.op 'push',
    direction: 'left'
    style: 'bar-resize:screenSizeX/2'
  j: S.op 'push',
    direction: 'down'
    style: 'bar-resize:screenSizeY/2'
  k: S.op 'push',
    direction: 'up'
    style: 'bar-resize:screenSizeY/2'
  l: S.op 'push',
    direction: 'right'
    style: 'bar-resize:screenSizeX/2'
  i: S.op 'move',
    x: 0
    y: 0
    width: 'screenSizeX/2'
    height: 'screenSizeY/2'
  o: S.op 'move',
    x: 'screenSizeX/2'
    y: 0
    width: 'screenSizeX/2'
    height: 'screenSizeY/2'
  m: S.op 'move',
    x: 'screenSizeX/2'
    y: 'screenSizeY/2'
    width: 'screenSizeX/2'
    height: 'screenSizeY/2'
  n: S.op 'move',
    x: 0
    y: 'screenSizeY/2'
    width: 'screenSizeX/2'
    height: 'screenSizeY/2'

for key, op of viLikeWindowPlacements
  S.bind vi(key), op

S.bindAll
  'r:ctrl,cmd': S.op 'relaunch'
  ']:cmd': S.op 'shell',
    command: '/usr/bin/open -a LimeChat'
  ';:cmd,shift': S.op 'shell', # XXX Cmd-:
    command: '/usr/bin/open -a iTerm'
  "':cmd": S.op 'shell',
    command: "~/.slate.d/google_chrome.sh"
