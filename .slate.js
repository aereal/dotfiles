S.configAll({
  defaultToCurrentScreen: true,
  checkDefaultsOnLoad: true,
  modalEscapeKey: 'esc'
});

var VI_LIKE_WINDOW_PLACEMENT_PREFIX_KEY = ['delete', 'ctrl', 'cmd'].join(',');

var vi = function(key) {
  return [key, VI_LIKE_WINDOW_PLACEMENT_PREFIX_KEY, 'toggle'].join(':');
};

var pushLeftOp = slate.op('push', {
  direction: 'left',
  style: 'bar-resize:screenSizeX/2'
});
var pushDownOp = slate.op('push', {
  direction: 'down',
  style: 'bar-resize:screenSizeY/2'
});
var pushUpOp = slate.op('push', {
  direction: 'up',
  style: 'bar-resize:screenSizeY/2'
});
var pushRightOp = slate.op('push', {
  direction: 'right',
  style: 'bar-resize:screenSizeX/2'
});
var moveTopLeftOp = slate.op('move', {
  x: 0,
  y: 0,
  width: 'screenSizeX/2',
  height: 'screenSizeY/2'
});
var moveTopRightOp =  slate.op('move', {
  x: 'screenSizeX/2',
  y: 0,
  width: 'screenSizeX/2',
  height: 'screenSizeY/2'
});
var moveBottomRightOp =  S.op('move', {
  x: 'screenSizeX/2',
  y: 'screenSizeY/2',
  width: 'screenSizeX/2',
  height: 'screenSizeY/2'
});
var moveBottomLeftOp = slate.op('move', {
  x: 0,
  y: 'screenSizeY/2',
  width: 'screenSizeX/2',
  height: 'screenSizeY/2'
});
var moveFullOp = slate.op('move', {
  x: 0,
  y: 0,
  width: 'screenSizeX',
  height: 'screenSizeY'
});

var viLikeWindowPlacements = {
  h: pushLeftOp,
  j: pushDownOp,
  k: pushUpOp,
  l: pushRightOp,
  i: moveTopLeftOp,
  o: moveTopRightOp,
  m: moveBottomRightOp,
  n: moveBottomLeftOp,
  'return': moveFullOp,
};

for (var key in viLikeWindowPlacements) {
  var op = viLikeWindowPlacements[key];
  S.bind(vi(key), op);
}

S.bindAll({
  'r:ctrl,cmd': S.op('relaunch'),
  'f:ctrl,cmd,shift': S.op('hint'),
});
