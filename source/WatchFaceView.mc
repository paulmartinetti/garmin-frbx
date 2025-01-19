import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;

class WatchFaceView extends WatchUi.WatchFace {
  // Define number representations (example for '0' and '1')
  var numberPatterns as Array = [
    [
      [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ],
      [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 0, 0, 0, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ],
      [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ],
      [ 1, 0, 0, 0, 0 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 0, 0, 1, 1, 1 ],
      [ 0, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ],
      [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 0 ], [ 1, 1, 1, 1, 1 ],
      [ 0, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 0 ], [ 1, 1, 1, 1, 1 ],
      [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ],
      [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ],
      [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ],
      [ 0, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ]
    ]
  ];

  var days as Array<String> = [
    "",           "un",          "deux",       "trois",       "quatre",
    "cinq",       "six",         "sept",       "huit",        "neuf",
    "dix",        "onze",        "douze",      "treize",      "quatorze",
    "quinze",     "seize",       "dix-sept",   "dix-huit",    "dix-neuf",
    "vingt",      "vingt-et-un", "vingt-deux", "vingt-trois", "vingt-quatre",
    "vingt-cinq", "vingt-six",   "vingt-sept", "vingt-huit",  "vingt-neuf",
    "trente",     "trente-et-un"
  ];

  // size of one square (multiply by 5 for number width)
  var size = 18;
  // half gap
  var hg = 3;
  // points
  var p1 = 195 - (size * 5) - hg;
  var p2 = 195 + hg;

  // move all up to allow text below
  var ydif = 20;

  // initial superclass, not the layout id
  function initialize() { WatchFace.initialize(); }

  // Load your resources here
  function onLayout(dc as Dc) as Void {}
  // setLayout(Rez.Layouts.WatchFace(dc));

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {}

  function drawNumber(dc as Graphics.Dc, number as Number, x as Number,
                      y as Number, size as Number) {
    var pattern = numberPatterns[number] as Array<Array>;
    for (var row = 0; row < pattern.size(); row++) {
      for (var col = 0; col < pattern[row].size(); col++) {
        if (pattern[row][col] == 1) {
          dc.fillRectangle(x + col * size, y + row * size, size, size);
        }
      }
    }
  }
  function drawTime(dc as Graphics.Dc, hour as Number, minute as Number) {
    // Adobe - font size 30, mousse script, export png x 1
    dc.setColor(0x8a8e1b, Graphics.COLOR_BLACK);

    // Draw hour (dc, number, x, y, size)
    // Tens place of hour
    drawNumber(dc, (hour / 10 % 10), p1, p1 - ydif, size);
    // Ones place of hour
    drawNumber(dc, (hour % 10), p2, p1 - ydif, size);

    // Draw minute
    // Tens place of minute
    drawNumber(dc, (minute / 10 % 10), p1, p2 - ydif, size);
    // Ones place of minute
    drawNumber(dc, (minute % 10), p2, p2 - ydif, size);
  }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Get and show the current time
    // var clockTime = System.getClockTime();

    // get date
    var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);

    // var view = View.findDrawableById("N"+today.day);
    // view.setText(dateString);
    // View.onUpdate(dc);

    dc.clear();

    var jourA = [
      0,
      Rez.Drawables.N1,
      Rez.Drawables.N2,
      Rez.Drawables.N3,
      Rez.Drawables.N4,
      Rez.Drawables.N5,
      Rez.Drawables.N6,
      Rez.Drawables.N7,
      Rez.Drawables.N8,
      Rez.Drawables.N9,
      Rez.Drawables.N10,
      Rez.Drawables.N11,
      Rez.Drawables.N12,
      Rez.Drawables.N13,
      Rez.Drawables.N14,
      Rez.Drawables.N15,
      Rez.Drawables.N16,
      Rez.Drawables.N17,
      Rez.Drawables.N18,
      Rez.Drawables.N19,
      Rez.Drawables.N20,
      Rez.Drawables.N21,
      Rez.Drawables.N22,
      Rez.Drawables.N23,
      Rez.Drawables.N24,
      Rez.Drawables.N25,
      Rez.Drawables.N26,
      Rez.Drawables.N27,
      Rez.Drawables.N28,
      Rez.Drawables.N29,
      Rez.Drawables.N30,
      Rez.Drawables.N31
    ];
    var image = Application.loadResource(jourA[today.day]) as BitmapResource;
    // launcher_icon.png is 30x30 px
    // white-square is 70x70 but is being expanded
    var ix = 195 - (image.getWidth() / 2);
    dc.drawBitmap(ix, 285, image);

    drawTime(dc, today.hour, today.min);

    // dc.setColor(0x8a8e1b);
    // dc.drawText(dateString, mousse, Graphics.TEXT_JUSTIFY_CENTER, 195, 290);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  // The user has just looked at their watch. Timers and animations may be
  // started here.
  function onExitSleep() as Void {}

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {}
}
