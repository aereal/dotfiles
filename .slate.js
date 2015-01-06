S.configAll({
  defaultToCurrentScreen: true,
  checkDefaultsOnLoad: true,
  modalEscapeKey: 'esc'
});

var VI_LIKE_WINDOW_PLACEMENT_PREFIX_KEY = ['delete', 'ctrl', 'cmd'].join(',');

var vi = function(key) {
  return [key, VI_LIKE_WINDOW_PLACEMENT_PREFIX_KEY, 'toggle'].join(':');
};

var viLikeWindowPlacements = {
  h: S.op('push', {
    direction: 'left',
    style: 'bar-resize:screenSizeX/2'
  }),
  j: S.op('push', {
    direction: 'down',
    style: 'bar-resize:screenSizeY/2'
  }),
  k: S.op('push', {
    direction: 'up',
    style: 'bar-resize:screenSizeY/2'
  }),
  l: S.op('push', {
    direction: 'right',
    style: 'bar-resize:screenSizeX/2'
  }),
  i: S.op('move', {
    x: 0,
    y: 0,
    width: 'screenSizeX/2',
    height: 'screenSizeY/2'
  }),
  o: S.op('move', {
    x: 'screenSizeX/2',
    y: 0,
    width: 'screenSizeX/2',
    height: 'screenSizeY/2'
  }),
  m: S.op('move', {
    x: 'screenSizeX/2',
    y: 'screenSizeY/2',
    width: 'screenSizeX/2',
    height: 'screenSizeY/2'
  }),
  n: S.op('move', {
    x: 0,
    y: 'screenSizeY/2',
    width: 'screenSizeX/2',
    height: 'screenSizeY/2'
  }),
  'return': S.op('move', {
    x: 0,
    y: 0,
    width: 'screenSizeX',
    height: 'screenSizeY'
  })
};

for (var key in viLikeWindowPlacements) {
  var op = viLikeWindowPlacements[key];
  S.bind(vi(key), op);
}

S.bindAll({
  'r:ctrl,cmd': S.op('relaunch'),
  'f:ctrl,cmd,shift': S.op('hint'),
  // ']:cmd': S.op('shell', {
  //   command: '/usr/bin/open -a LimeChat'
  // }),
  // ';:cmd,shift': S.op('shell', {
  //   command: '/usr/bin/open -a iTerm'
  // }),
  // "[:cmd" : S.op('shell', {
  //   command: '/usr/bin/open -a MacVim'
  // })
});
