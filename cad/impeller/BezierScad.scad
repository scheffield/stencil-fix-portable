/* 
  Bezier functions for OpenScad
  Generated from BezierScad.coffee from darwin at Fri May 10 2013 22:59:02 GMT-0700 (PDT)
  Supports Bezier interpolation with 1-8 controls
  Sources/Inspirations:
    http://en.wikipedia.org/wiki/Bézier_curve
    http://www.cs.mtu.edu/~shene/COURSES/cs3621/NOTES/spline/Bezier/bezier-der.html
    http://www.thingiverse.com/thing:8443

Copyright (c) 2013 Chad Kirby

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/


module BezLine(ctlPts, width = [1], resolution = 4, centered = false, showCtls = true) {
  hodoPts = hodograph(ctlPts);
  if (showCtls) {
    for (pt = ctlPts) {
      % translate([pt[0], pt[1], 0]) circle(1);
    }
  }
  if (resolution == 2) {
    if (centered) {
      polygon([
        PerpAlongBez(0/3, ctlPts, dist = BezI(0/3, width)/2, hodograph = hodoPts), PerpAlongBez(1/3, ctlPts, dist = BezI(1/3, width)/2, hodograph = hodoPts), PerpAlongBez(2/3, ctlPts, dist = BezI(2/3, width)/2, hodograph = hodoPts), PerpAlongBez(3/3, ctlPts, dist = BezI(3/3, width)/2, hodograph = hodoPts), PerpAlongBez(3/3, ctlPts, dist = BezI(3/3, width)/-2, hodograph = hodoPts), PerpAlongBez(2/3, ctlPts, dist = BezI(2/3, width)/-2, hodograph = hodoPts), PerpAlongBez(1/3, ctlPts, dist = BezI(1/3, width)/-2, hodograph = hodoPts), PerpAlongBez(0/3, ctlPts, dist = BezI(0/3, width)/-2, hodograph = hodoPts)
      ]);
    } else {
      polygon([
        PointAlongBez(0/3, ctlPts), PointAlongBez(1/3, ctlPts), PointAlongBez(2/3, ctlPts), PointAlongBez(3/3, ctlPts), PerpAlongBez(3/3, ctlPts, dist = BezI(3/3, width), hodograph = hodoPts), PerpAlongBez(2/3, ctlPts, dist = BezI(2/3, width), hodograph = hodoPts), PerpAlongBez(1/3, ctlPts, dist = BezI(1/3, width), hodograph = hodoPts), PerpAlongBez(0/3, ctlPts, dist = BezI(0/3, width), hodograph = hodoPts)
      ]);
    }
  } else if (resolution == 3) {
    if (centered) {
      polygon([
        PerpAlongBez(0/7, ctlPts, dist = BezI(0/7, width)/2, hodograph = hodoPts), PerpAlongBez(1/7, ctlPts, dist = BezI(1/7, width)/2, hodograph = hodoPts), PerpAlongBez(2/7, ctlPts, dist = BezI(2/7, width)/2, hodograph = hodoPts), PerpAlongBez(3/7, ctlPts, dist = BezI(3/7, width)/2, hodograph = hodoPts), PerpAlongBez(4/7, ctlPts, dist = BezI(4/7, width)/2, hodograph = hodoPts), PerpAlongBez(5/7, ctlPts, dist = BezI(5/7, width)/2, hodograph = hodoPts), PerpAlongBez(6/7, ctlPts, dist = BezI(6/7, width)/2, hodograph = hodoPts), PerpAlongBez(7/7, ctlPts, dist = BezI(7/7, width)/2, hodograph = hodoPts), PerpAlongBez(7/7, ctlPts, dist = BezI(7/7, width)/-2, hodograph = hodoPts), PerpAlongBez(6/7, ctlPts, dist = BezI(6/7, width)/-2, hodograph = hodoPts), PerpAlongBez(5/7, ctlPts, dist = BezI(5/7, width)/-2, hodograph = hodoPts), PerpAlongBez(4/7, ctlPts, dist = BezI(4/7, width)/-2, hodograph = hodoPts), PerpAlongBez(3/7, ctlPts, dist = BezI(3/7, width)/-2, hodograph = hodoPts), PerpAlongBez(2/7, ctlPts, dist = BezI(2/7, width)/-2, hodograph = hodoPts), PerpAlongBez(1/7, ctlPts, dist = BezI(1/7, width)/-2, hodograph = hodoPts), PerpAlongBez(0/7, ctlPts, dist = BezI(0/7, width)/-2, hodograph = hodoPts)
      ]);
    } else {
      polygon([
        PointAlongBez(0/7, ctlPts), PointAlongBez(1/7, ctlPts), PointAlongBez(2/7, ctlPts), PointAlongBez(3/7, ctlPts), PointAlongBez(4/7, ctlPts), PointAlongBez(5/7, ctlPts), PointAlongBez(6/7, ctlPts), PointAlongBez(7/7, ctlPts), PerpAlongBez(7/7, ctlPts, dist = BezI(7/7, width), hodograph = hodoPts), PerpAlongBez(6/7, ctlPts, dist = BezI(6/7, width), hodograph = hodoPts), PerpAlongBez(5/7, ctlPts, dist = BezI(5/7, width), hodograph = hodoPts), PerpAlongBez(4/7, ctlPts, dist = BezI(4/7, width), hodograph = hodoPts), PerpAlongBez(3/7, ctlPts, dist = BezI(3/7, width), hodograph = hodoPts), PerpAlongBez(2/7, ctlPts, dist = BezI(2/7, width), hodograph = hodoPts), PerpAlongBez(1/7, ctlPts, dist = BezI(1/7, width), hodograph = hodoPts), PerpAlongBez(0/7, ctlPts, dist = BezI(0/7, width), hodograph = hodoPts)
      ]);
    }
  } else if (resolution == 4) {
    if (centered) {
      polygon([
        PerpAlongBez(0/15, ctlPts, dist = BezI(0/15, width)/2, hodograph = hodoPts), PerpAlongBez(1/15, ctlPts, dist = BezI(1/15, width)/2, hodograph = hodoPts), PerpAlongBez(2/15, ctlPts, dist = BezI(2/15, width)/2, hodograph = hodoPts), PerpAlongBez(3/15, ctlPts, dist = BezI(3/15, width)/2, hodograph = hodoPts), PerpAlongBez(4/15, ctlPts, dist = BezI(4/15, width)/2, hodograph = hodoPts), PerpAlongBez(5/15, ctlPts, dist = BezI(5/15, width)/2, hodograph = hodoPts), PerpAlongBez(6/15, ctlPts, dist = BezI(6/15, width)/2, hodograph = hodoPts), PerpAlongBez(7/15, ctlPts, dist = BezI(7/15, width)/2, hodograph = hodoPts), PerpAlongBez(8/15, ctlPts, dist = BezI(8/15, width)/2, hodograph = hodoPts), PerpAlongBez(9/15, ctlPts, dist = BezI(9/15, width)/2, hodograph = hodoPts), PerpAlongBez(10/15, ctlPts, dist = BezI(10/15, width)/2, hodograph = hodoPts), PerpAlongBez(11/15, ctlPts, dist = BezI(11/15, width)/2, hodograph = hodoPts), PerpAlongBez(12/15, ctlPts, dist = BezI(12/15, width)/2, hodograph = hodoPts), PerpAlongBez(13/15, ctlPts, dist = BezI(13/15, width)/2, hodograph = hodoPts), PerpAlongBez(14/15, ctlPts, dist = BezI(14/15, width)/2, hodograph = hodoPts), PerpAlongBez(15/15, ctlPts, dist = BezI(15/15, width)/2, hodograph = hodoPts), PerpAlongBez(15/15, ctlPts, dist = BezI(15/15, width)/-2, hodograph = hodoPts), PerpAlongBez(14/15, ctlPts, dist = BezI(14/15, width)/-2, hodograph = hodoPts), PerpAlongBez(13/15, ctlPts, dist = BezI(13/15, width)/-2, hodograph = hodoPts), PerpAlongBez(12/15, ctlPts, dist = BezI(12/15, width)/-2, hodograph = hodoPts), PerpAlongBez(11/15, ctlPts, dist = BezI(11/15, width)/-2, hodograph = hodoPts), PerpAlongBez(10/15, ctlPts, dist = BezI(10/15, width)/-2, hodograph = hodoPts), PerpAlongBez(9/15, ctlPts, dist = BezI(9/15, width)/-2, hodograph = hodoPts), PerpAlongBez(8/15, ctlPts, dist = BezI(8/15, width)/-2, hodograph = hodoPts), PerpAlongBez(7/15, ctlPts, dist = BezI(7/15, width)/-2, hodograph = hodoPts), PerpAlongBez(6/15, ctlPts, dist = BezI(6/15, width)/-2, hodograph = hodoPts), PerpAlongBez(5/15, ctlPts, dist = BezI(5/15, width)/-2, hodograph = hodoPts), PerpAlongBez(4/15, ctlPts, dist = BezI(4/15, width)/-2, hodograph = hodoPts), PerpAlongBez(3/15, ctlPts, dist = BezI(3/15, width)/-2, hodograph = hodoPts), PerpAlongBez(2/15, ctlPts, dist = BezI(2/15, width)/-2, hodograph = hodoPts), PerpAlongBez(1/15, ctlPts, dist = BezI(1/15, width)/-2, hodograph = hodoPts), PerpAlongBez(0/15, ctlPts, dist = BezI(0/15, width)/-2, hodograph = hodoPts)
      ]);
    } else {
      polygon([
        PointAlongBez(0/15, ctlPts), PointAlongBez(1/15, ctlPts), PointAlongBez(2/15, ctlPts), PointAlongBez(3/15, ctlPts), PointAlongBez(4/15, ctlPts), PointAlongBez(5/15, ctlPts), PointAlongBez(6/15, ctlPts), PointAlongBez(7/15, ctlPts), PointAlongBez(8/15, ctlPts), PointAlongBez(9/15, ctlPts), PointAlongBez(10/15, ctlPts), PointAlongBez(11/15, ctlPts), PointAlongBez(12/15, ctlPts), PointAlongBez(13/15, ctlPts), PointAlongBez(14/15, ctlPts), PointAlongBez(15/15, ctlPts), PerpAlongBez(15/15, ctlPts, dist = BezI(15/15, width), hodograph = hodoPts), PerpAlongBez(14/15, ctlPts, dist = BezI(14/15, width), hodograph = hodoPts), PerpAlongBez(13/15, ctlPts, dist = BezI(13/15, width), hodograph = hodoPts), PerpAlongBez(12/15, ctlPts, dist = BezI(12/15, width), hodograph = hodoPts), PerpAlongBez(11/15, ctlPts, dist = BezI(11/15, width), hodograph = hodoPts), PerpAlongBez(10/15, ctlPts, dist = BezI(10/15, width), hodograph = hodoPts), PerpAlongBez(9/15, ctlPts, dist = BezI(9/15, width), hodograph = hodoPts), PerpAlongBez(8/15, ctlPts, dist = BezI(8/15, width), hodograph = hodoPts), PerpAlongBez(7/15, ctlPts, dist = BezI(7/15, width), hodograph = hodoPts), PerpAlongBez(6/15, ctlPts, dist = BezI(6/15, width), hodograph = hodoPts), PerpAlongBez(5/15, ctlPts, dist = BezI(5/15, width), hodograph = hodoPts), PerpAlongBez(4/15, ctlPts, dist = BezI(4/15, width), hodograph = hodoPts), PerpAlongBez(3/15, ctlPts, dist = BezI(3/15, width), hodograph = hodoPts), PerpAlongBez(2/15, ctlPts, dist = BezI(2/15, width), hodograph = hodoPts), PerpAlongBez(1/15, ctlPts, dist = BezI(1/15, width), hodograph = hodoPts), PerpAlongBez(0/15, ctlPts, dist = BezI(0/15, width), hodograph = hodoPts)
      ]);
    }
  } else if (resolution == 5) {
    if (centered) {
      polygon([
        PerpAlongBez(0/31, ctlPts, dist = BezI(0/31, width)/2, hodograph = hodoPts), PerpAlongBez(1/31, ctlPts, dist = BezI(1/31, width)/2, hodograph = hodoPts), PerpAlongBez(2/31, ctlPts, dist = BezI(2/31, width)/2, hodograph = hodoPts), PerpAlongBez(3/31, ctlPts, dist = BezI(3/31, width)/2, hodograph = hodoPts), PerpAlongBez(4/31, ctlPts, dist = BezI(4/31, width)/2, hodograph = hodoPts), PerpAlongBez(5/31, ctlPts, dist = BezI(5/31, width)/2, hodograph = hodoPts), PerpAlongBez(6/31, ctlPts, dist = BezI(6/31, width)/2, hodograph = hodoPts), PerpAlongBez(7/31, ctlPts, dist = BezI(7/31, width)/2, hodograph = hodoPts), PerpAlongBez(8/31, ctlPts, dist = BezI(8/31, width)/2, hodograph = hodoPts), PerpAlongBez(9/31, ctlPts, dist = BezI(9/31, width)/2, hodograph = hodoPts), PerpAlongBez(10/31, ctlPts, dist = BezI(10/31, width)/2, hodograph = hodoPts), PerpAlongBez(11/31, ctlPts, dist = BezI(11/31, width)/2, hodograph = hodoPts), PerpAlongBez(12/31, ctlPts, dist = BezI(12/31, width)/2, hodograph = hodoPts), PerpAlongBez(13/31, ctlPts, dist = BezI(13/31, width)/2, hodograph = hodoPts), PerpAlongBez(14/31, ctlPts, dist = BezI(14/31, width)/2, hodograph = hodoPts), PerpAlongBez(15/31, ctlPts, dist = BezI(15/31, width)/2, hodograph = hodoPts), PerpAlongBez(16/31, ctlPts, dist = BezI(16/31, width)/2, hodograph = hodoPts), PerpAlongBez(17/31, ctlPts, dist = BezI(17/31, width)/2, hodograph = hodoPts), PerpAlongBez(18/31, ctlPts, dist = BezI(18/31, width)/2, hodograph = hodoPts), PerpAlongBez(19/31, ctlPts, dist = BezI(19/31, width)/2, hodograph = hodoPts), PerpAlongBez(20/31, ctlPts, dist = BezI(20/31, width)/2, hodograph = hodoPts), PerpAlongBez(21/31, ctlPts, dist = BezI(21/31, width)/2, hodograph = hodoPts), PerpAlongBez(22/31, ctlPts, dist = BezI(22/31, width)/2, hodograph = hodoPts), PerpAlongBez(23/31, ctlPts, dist = BezI(23/31, width)/2, hodograph = hodoPts), PerpAlongBez(24/31, ctlPts, dist = BezI(24/31, width)/2, hodograph = hodoPts), PerpAlongBez(25/31, ctlPts, dist = BezI(25/31, width)/2, hodograph = hodoPts), PerpAlongBez(26/31, ctlPts, dist = BezI(26/31, width)/2, hodograph = hodoPts), PerpAlongBez(27/31, ctlPts, dist = BezI(27/31, width)/2, hodograph = hodoPts), PerpAlongBez(28/31, ctlPts, dist = BezI(28/31, width)/2, hodograph = hodoPts), PerpAlongBez(29/31, ctlPts, dist = BezI(29/31, width)/2, hodograph = hodoPts), PerpAlongBez(30/31, ctlPts, dist = BezI(30/31, width)/2, hodograph = hodoPts), PerpAlongBez(31/31, ctlPts, dist = BezI(31/31, width)/2, hodograph = hodoPts), PerpAlongBez(31/31, ctlPts, dist = BezI(31/31, width)/-2, hodograph = hodoPts), PerpAlongBez(30/31, ctlPts, dist = BezI(30/31, width)/-2, hodograph = hodoPts), PerpAlongBez(29/31, ctlPts, dist = BezI(29/31, width)/-2, hodograph = hodoPts), PerpAlongBez(28/31, ctlPts, dist = BezI(28/31, width)/-2, hodograph = hodoPts), PerpAlongBez(27/31, ctlPts, dist = BezI(27/31, width)/-2, hodograph = hodoPts), PerpAlongBez(26/31, ctlPts, dist = BezI(26/31, width)/-2, hodograph = hodoPts), PerpAlongBez(25/31, ctlPts, dist = BezI(25/31, width)/-2, hodograph = hodoPts), PerpAlongBez(24/31, ctlPts, dist = BezI(24/31, width)/-2, hodograph = hodoPts), PerpAlongBez(23/31, ctlPts, dist = BezI(23/31, width)/-2, hodograph = hodoPts), PerpAlongBez(22/31, ctlPts, dist = BezI(22/31, width)/-2, hodograph = hodoPts), PerpAlongBez(21/31, ctlPts, dist = BezI(21/31, width)/-2, hodograph = hodoPts), PerpAlongBez(20/31, ctlPts, dist = BezI(20/31, width)/-2, hodograph = hodoPts), PerpAlongBez(19/31, ctlPts, dist = BezI(19/31, width)/-2, hodograph = hodoPts), PerpAlongBez(18/31, ctlPts, dist = BezI(18/31, width)/-2, hodograph = hodoPts), PerpAlongBez(17/31, ctlPts, dist = BezI(17/31, width)/-2, hodograph = hodoPts), PerpAlongBez(16/31, ctlPts, dist = BezI(16/31, width)/-2, hodograph = hodoPts), PerpAlongBez(15/31, ctlPts, dist = BezI(15/31, width)/-2, hodograph = hodoPts), PerpAlongBez(14/31, ctlPts, dist = BezI(14/31, width)/-2, hodograph = hodoPts), PerpAlongBez(13/31, ctlPts, dist = BezI(13/31, width)/-2, hodograph = hodoPts), PerpAlongBez(12/31, ctlPts, dist = BezI(12/31, width)/-2, hodograph = hodoPts), PerpAlongBez(11/31, ctlPts, dist = BezI(11/31, width)/-2, hodograph = hodoPts), PerpAlongBez(10/31, ctlPts, dist = BezI(10/31, width)/-2, hodograph = hodoPts), PerpAlongBez(9/31, ctlPts, dist = BezI(9/31, width)/-2, hodograph = hodoPts), PerpAlongBez(8/31, ctlPts, dist = BezI(8/31, width)/-2, hodograph = hodoPts), PerpAlongBez(7/31, ctlPts, dist = BezI(7/31, width)/-2, hodograph = hodoPts), PerpAlongBez(6/31, ctlPts, dist = BezI(6/31, width)/-2, hodograph = hodoPts), PerpAlongBez(5/31, ctlPts, dist = BezI(5/31, width)/-2, hodograph = hodoPts), PerpAlongBez(4/31, ctlPts, dist = BezI(4/31, width)/-2, hodograph = hodoPts), PerpAlongBez(3/31, ctlPts, dist = BezI(3/31, width)/-2, hodograph = hodoPts), PerpAlongBez(2/31, ctlPts, dist = BezI(2/31, width)/-2, hodograph = hodoPts), PerpAlongBez(1/31, ctlPts, dist = BezI(1/31, width)/-2, hodograph = hodoPts), PerpAlongBez(0/31, ctlPts, dist = BezI(0/31, width)/-2, hodograph = hodoPts)
      ]);
    } else {
      polygon([
        PointAlongBez(0/31, ctlPts), PointAlongBez(1/31, ctlPts), PointAlongBez(2/31, ctlPts), PointAlongBez(3/31, ctlPts), PointAlongBez(4/31, ctlPts), PointAlongBez(5/31, ctlPts), PointAlongBez(6/31, ctlPts), PointAlongBez(7/31, ctlPts), PointAlongBez(8/31, ctlPts), PointAlongBez(9/31, ctlPts), PointAlongBez(10/31, ctlPts), PointAlongBez(11/31, ctlPts), PointAlongBez(12/31, ctlPts), PointAlongBez(13/31, ctlPts), PointAlongBez(14/31, ctlPts), PointAlongBez(15/31, ctlPts), PointAlongBez(16/31, ctlPts), PointAlongBez(17/31, ctlPts), PointAlongBez(18/31, ctlPts), PointAlongBez(19/31, ctlPts), PointAlongBez(20/31, ctlPts), PointAlongBez(21/31, ctlPts), PointAlongBez(22/31, ctlPts), PointAlongBez(23/31, ctlPts), PointAlongBez(24/31, ctlPts), PointAlongBez(25/31, ctlPts), PointAlongBez(26/31, ctlPts), PointAlongBez(27/31, ctlPts), PointAlongBez(28/31, ctlPts), PointAlongBez(29/31, ctlPts), PointAlongBez(30/31, ctlPts), PointAlongBez(31/31, ctlPts), PerpAlongBez(31/31, ctlPts, dist = BezI(31/31, width), hodograph = hodoPts), PerpAlongBez(30/31, ctlPts, dist = BezI(30/31, width), hodograph = hodoPts), PerpAlongBez(29/31, ctlPts, dist = BezI(29/31, width), hodograph = hodoPts), PerpAlongBez(28/31, ctlPts, dist = BezI(28/31, width), hodograph = hodoPts), PerpAlongBez(27/31, ctlPts, dist = BezI(27/31, width), hodograph = hodoPts), PerpAlongBez(26/31, ctlPts, dist = BezI(26/31, width), hodograph = hodoPts), PerpAlongBez(25/31, ctlPts, dist = BezI(25/31, width), hodograph = hodoPts), PerpAlongBez(24/31, ctlPts, dist = BezI(24/31, width), hodograph = hodoPts), PerpAlongBez(23/31, ctlPts, dist = BezI(23/31, width), hodograph = hodoPts), PerpAlongBez(22/31, ctlPts, dist = BezI(22/31, width), hodograph = hodoPts), PerpAlongBez(21/31, ctlPts, dist = BezI(21/31, width), hodograph = hodoPts), PerpAlongBez(20/31, ctlPts, dist = BezI(20/31, width), hodograph = hodoPts), PerpAlongBez(19/31, ctlPts, dist = BezI(19/31, width), hodograph = hodoPts), PerpAlongBez(18/31, ctlPts, dist = BezI(18/31, width), hodograph = hodoPts), PerpAlongBez(17/31, ctlPts, dist = BezI(17/31, width), hodograph = hodoPts), PerpAlongBez(16/31, ctlPts, dist = BezI(16/31, width), hodograph = hodoPts), PerpAlongBez(15/31, ctlPts, dist = BezI(15/31, width), hodograph = hodoPts), PerpAlongBez(14/31, ctlPts, dist = BezI(14/31, width), hodograph = hodoPts), PerpAlongBez(13/31, ctlPts, dist = BezI(13/31, width), hodograph = hodoPts), PerpAlongBez(12/31, ctlPts, dist = BezI(12/31, width), hodograph = hodoPts), PerpAlongBez(11/31, ctlPts, dist = BezI(11/31, width), hodograph = hodoPts), PerpAlongBez(10/31, ctlPts, dist = BezI(10/31, width), hodograph = hodoPts), PerpAlongBez(9/31, ctlPts, dist = BezI(9/31, width), hodograph = hodoPts), PerpAlongBez(8/31, ctlPts, dist = BezI(8/31, width), hodograph = hodoPts), PerpAlongBez(7/31, ctlPts, dist = BezI(7/31, width), hodograph = hodoPts), PerpAlongBez(6/31, ctlPts, dist = BezI(6/31, width), hodograph = hodoPts), PerpAlongBez(5/31, ctlPts, dist = BezI(5/31, width), hodograph = hodoPts), PerpAlongBez(4/31, ctlPts, dist = BezI(4/31, width), hodograph = hodoPts), PerpAlongBez(3/31, ctlPts, dist = BezI(3/31, width), hodograph = hodoPts), PerpAlongBez(2/31, ctlPts, dist = BezI(2/31, width), hodograph = hodoPts), PerpAlongBez(1/31, ctlPts, dist = BezI(1/31, width), hodograph = hodoPts), PerpAlongBez(0/31, ctlPts, dist = BezI(0/31, width), hodograph = hodoPts)
      ]);
    }
  } else if (resolution == 6) {
    if (centered) {
      polygon([
        PerpAlongBez(0/63, ctlPts, dist = BezI(0/63, width)/2, hodograph = hodoPts), PerpAlongBez(1/63, ctlPts, dist = BezI(1/63, width)/2, hodograph = hodoPts), PerpAlongBez(2/63, ctlPts, dist = BezI(2/63, width)/2, hodograph = hodoPts), PerpAlongBez(3/63, ctlPts, dist = BezI(3/63, width)/2, hodograph = hodoPts), PerpAlongBez(4/63, ctlPts, dist = BezI(4/63, width)/2, hodograph = hodoPts), PerpAlongBez(5/63, ctlPts, dist = BezI(5/63, width)/2, hodograph = hodoPts), PerpAlongBez(6/63, ctlPts, dist = BezI(6/63, width)/2, hodograph = hodoPts), PerpAlongBez(7/63, ctlPts, dist = BezI(7/63, width)/2, hodograph = hodoPts), PerpAlongBez(8/63, ctlPts, dist = BezI(8/63, width)/2, hodograph = hodoPts), PerpAlongBez(9/63, ctlPts, dist = BezI(9/63, width)/2, hodograph = hodoPts), PerpAlongBez(10/63, ctlPts, dist = BezI(10/63, width)/2, hodograph = hodoPts), PerpAlongBez(11/63, ctlPts, dist = BezI(11/63, width)/2, hodograph = hodoPts), PerpAlongBez(12/63, ctlPts, dist = BezI(12/63, width)/2, hodograph = hodoPts), PerpAlongBez(13/63, ctlPts, dist = BezI(13/63, width)/2, hodograph = hodoPts), PerpAlongBez(14/63, ctlPts, dist = BezI(14/63, width)/2, hodograph = hodoPts), PerpAlongBez(15/63, ctlPts, dist = BezI(15/63, width)/2, hodograph = hodoPts), PerpAlongBez(16/63, ctlPts, dist = BezI(16/63, width)/2, hodograph = hodoPts), PerpAlongBez(17/63, ctlPts, dist = BezI(17/63, width)/2, hodograph = hodoPts), PerpAlongBez(18/63, ctlPts, dist = BezI(18/63, width)/2, hodograph = hodoPts), PerpAlongBez(19/63, ctlPts, dist = BezI(19/63, width)/2, hodograph = hodoPts), PerpAlongBez(20/63, ctlPts, dist = BezI(20/63, width)/2, hodograph = hodoPts), PerpAlongBez(21/63, ctlPts, dist = BezI(21/63, width)/2, hodograph = hodoPts), PerpAlongBez(22/63, ctlPts, dist = BezI(22/63, width)/2, hodograph = hodoPts), PerpAlongBez(23/63, ctlPts, dist = BezI(23/63, width)/2, hodograph = hodoPts), PerpAlongBez(24/63, ctlPts, dist = BezI(24/63, width)/2, hodograph = hodoPts), PerpAlongBez(25/63, ctlPts, dist = BezI(25/63, width)/2, hodograph = hodoPts), PerpAlongBez(26/63, ctlPts, dist = BezI(26/63, width)/2, hodograph = hodoPts), PerpAlongBez(27/63, ctlPts, dist = BezI(27/63, width)/2, hodograph = hodoPts), PerpAlongBez(28/63, ctlPts, dist = BezI(28/63, width)/2, hodograph = hodoPts), PerpAlongBez(29/63, ctlPts, dist = BezI(29/63, width)/2, hodograph = hodoPts), PerpAlongBez(30/63, ctlPts, dist = BezI(30/63, width)/2, hodograph = hodoPts), PerpAlongBez(31/63, ctlPts, dist = BezI(31/63, width)/2, hodograph = hodoPts), PerpAlongBez(32/63, ctlPts, dist = BezI(32/63, width)/2, hodograph = hodoPts), PerpAlongBez(33/63, ctlPts, dist = BezI(33/63, width)/2, hodograph = hodoPts), PerpAlongBez(34/63, ctlPts, dist = BezI(34/63, width)/2, hodograph = hodoPts), PerpAlongBez(35/63, ctlPts, dist = BezI(35/63, width)/2, hodograph = hodoPts), PerpAlongBez(36/63, ctlPts, dist = BezI(36/63, width)/2, hodograph = hodoPts), PerpAlongBez(37/63, ctlPts, dist = BezI(37/63, width)/2, hodograph = hodoPts), PerpAlongBez(38/63, ctlPts, dist = BezI(38/63, width)/2, hodograph = hodoPts), PerpAlongBez(39/63, ctlPts, dist = BezI(39/63, width)/2, hodograph = hodoPts), PerpAlongBez(40/63, ctlPts, dist = BezI(40/63, width)/2, hodograph = hodoPts), PerpAlongBez(41/63, ctlPts, dist = BezI(41/63, width)/2, hodograph = hodoPts), PerpAlongBez(42/63, ctlPts, dist = BezI(42/63, width)/2, hodograph = hodoPts), PerpAlongBez(43/63, ctlPts, dist = BezI(43/63, width)/2, hodograph = hodoPts), PerpAlongBez(44/63, ctlPts, dist = BezI(44/63, width)/2, hodograph = hodoPts), PerpAlongBez(45/63, ctlPts, dist = BezI(45/63, width)/2, hodograph = hodoPts), PerpAlongBez(46/63, ctlPts, dist = BezI(46/63, width)/2, hodograph = hodoPts), PerpAlongBez(47/63, ctlPts, dist = BezI(47/63, width)/2, hodograph = hodoPts), PerpAlongBez(48/63, ctlPts, dist = BezI(48/63, width)/2, hodograph = hodoPts), PerpAlongBez(49/63, ctlPts, dist = BezI(49/63, width)/2, hodograph = hodoPts), PerpAlongBez(50/63, ctlPts, dist = BezI(50/63, width)/2, hodograph = hodoPts), PerpAlongBez(51/63, ctlPts, dist = BezI(51/63, width)/2, hodograph = hodoPts), PerpAlongBez(52/63, ctlPts, dist = BezI(52/63, width)/2, hodograph = hodoPts), PerpAlongBez(53/63, ctlPts, dist = BezI(53/63, width)/2, hodograph = hodoPts), PerpAlongBez(54/63, ctlPts, dist = BezI(54/63, width)/2, hodograph = hodoPts), PerpAlongBez(55/63, ctlPts, dist = BezI(55/63, width)/2, hodograph = hodoPts), PerpAlongBez(56/63, ctlPts, dist = BezI(56/63, width)/2, hodograph = hodoPts), PerpAlongBez(57/63, ctlPts, dist = BezI(57/63, width)/2, hodograph = hodoPts), PerpAlongBez(58/63, ctlPts, dist = BezI(58/63, width)/2, hodograph = hodoPts), PerpAlongBez(59/63, ctlPts, dist = BezI(59/63, width)/2, hodograph = hodoPts), PerpAlongBez(60/63, ctlPts, dist = BezI(60/63, width)/2, hodograph = hodoPts), PerpAlongBez(61/63, ctlPts, dist = BezI(61/63, width)/2, hodograph = hodoPts), PerpAlongBez(62/63, ctlPts, dist = BezI(62/63, width)/2, hodograph = hodoPts), PerpAlongBez(63/63, ctlPts, dist = BezI(63/63, width)/2, hodograph = hodoPts), PerpAlongBez(63/63, ctlPts, dist = BezI(63/63, width)/-2, hodograph = hodoPts), PerpAlongBez(62/63, ctlPts, dist = BezI(62/63, width)/-2, hodograph = hodoPts), PerpAlongBez(61/63, ctlPts, dist = BezI(61/63, width)/-2, hodograph = hodoPts), PerpAlongBez(60/63, ctlPts, dist = BezI(60/63, width)/-2, hodograph = hodoPts), PerpAlongBez(59/63, ctlPts, dist = BezI(59/63, width)/-2, hodograph = hodoPts), PerpAlongBez(58/63, ctlPts, dist = BezI(58/63, width)/-2, hodograph = hodoPts), PerpAlongBez(57/63, ctlPts, dist = BezI(57/63, width)/-2, hodograph = hodoPts), PerpAlongBez(56/63, ctlPts, dist = BezI(56/63, width)/-2, hodograph = hodoPts), PerpAlongBez(55/63, ctlPts, dist = BezI(55/63, width)/-2, hodograph = hodoPts), PerpAlongBez(54/63, ctlPts, dist = BezI(54/63, width)/-2, hodograph = hodoPts), PerpAlongBez(53/63, ctlPts, dist = BezI(53/63, width)/-2, hodograph = hodoPts), PerpAlongBez(52/63, ctlPts, dist = BezI(52/63, width)/-2, hodograph = hodoPts), PerpAlongBez(51/63, ctlPts, dist = BezI(51/63, width)/-2, hodograph = hodoPts), PerpAlongBez(50/63, ctlPts, dist = BezI(50/63, width)/-2, hodograph = hodoPts), PerpAlongBez(49/63, ctlPts, dist = BezI(49/63, width)/-2, hodograph = hodoPts), PerpAlongBez(48/63, ctlPts, dist = BezI(48/63, width)/-2, hodograph = hodoPts), PerpAlongBez(47/63, ctlPts, dist = BezI(47/63, width)/-2, hodograph = hodoPts), PerpAlongBez(46/63, ctlPts, dist = BezI(46/63, width)/-2, hodograph = hodoPts), PerpAlongBez(45/63, ctlPts, dist = BezI(45/63, width)/-2, hodograph = hodoPts), PerpAlongBez(44/63, ctlPts, dist = BezI(44/63, width)/-2, hodograph = hodoPts), PerpAlongBez(43/63, ctlPts, dist = BezI(43/63, width)/-2, hodograph = hodoPts), PerpAlongBez(42/63, ctlPts, dist = BezI(42/63, width)/-2, hodograph = hodoPts), PerpAlongBez(41/63, ctlPts, dist = BezI(41/63, width)/-2, hodograph = hodoPts), PerpAlongBez(40/63, ctlPts, dist = BezI(40/63, width)/-2, hodograph = hodoPts), PerpAlongBez(39/63, ctlPts, dist = BezI(39/63, width)/-2, hodograph = hodoPts), PerpAlongBez(38/63, ctlPts, dist = BezI(38/63, width)/-2, hodograph = hodoPts), PerpAlongBez(37/63, ctlPts, dist = BezI(37/63, width)/-2, hodograph = hodoPts), PerpAlongBez(36/63, ctlPts, dist = BezI(36/63, width)/-2, hodograph = hodoPts), PerpAlongBez(35/63, ctlPts, dist = BezI(35/63, width)/-2, hodograph = hodoPts), PerpAlongBez(34/63, ctlPts, dist = BezI(34/63, width)/-2, hodograph = hodoPts), PerpAlongBez(33/63, ctlPts, dist = BezI(33/63, width)/-2, hodograph = hodoPts), PerpAlongBez(32/63, ctlPts, dist = BezI(32/63, width)/-2, hodograph = hodoPts), PerpAlongBez(31/63, ctlPts, dist = BezI(31/63, width)/-2, hodograph = hodoPts), PerpAlongBez(30/63, ctlPts, dist = BezI(30/63, width)/-2, hodograph = hodoPts), PerpAlongBez(29/63, ctlPts, dist = BezI(29/63, width)/-2, hodograph = hodoPts), PerpAlongBez(28/63, ctlPts, dist = BezI(28/63, width)/-2, hodograph = hodoPts), PerpAlongBez(27/63, ctlPts, dist = BezI(27/63, width)/-2, hodograph = hodoPts), PerpAlongBez(26/63, ctlPts, dist = BezI(26/63, width)/-2, hodograph = hodoPts), PerpAlongBez(25/63, ctlPts, dist = BezI(25/63, width)/-2, hodograph = hodoPts), PerpAlongBez(24/63, ctlPts, dist = BezI(24/63, width)/-2, hodograph = hodoPts), PerpAlongBez(23/63, ctlPts, dist = BezI(23/63, width)/-2, hodograph = hodoPts), PerpAlongBez(22/63, ctlPts, dist = BezI(22/63, width)/-2, hodograph = hodoPts), PerpAlongBez(21/63, ctlPts, dist = BezI(21/63, width)/-2, hodograph = hodoPts), PerpAlongBez(20/63, ctlPts, dist = BezI(20/63, width)/-2, hodograph = hodoPts), PerpAlongBez(19/63, ctlPts, dist = BezI(19/63, width)/-2, hodograph = hodoPts), PerpAlongBez(18/63, ctlPts, dist = BezI(18/63, width)/-2, hodograph = hodoPts), PerpAlongBez(17/63, ctlPts, dist = BezI(17/63, width)/-2, hodograph = hodoPts), PerpAlongBez(16/63, ctlPts, dist = BezI(16/63, width)/-2, hodograph = hodoPts), PerpAlongBez(15/63, ctlPts, dist = BezI(15/63, width)/-2, hodograph = hodoPts), PerpAlongBez(14/63, ctlPts, dist = BezI(14/63, width)/-2, hodograph = hodoPts), PerpAlongBez(13/63, ctlPts, dist = BezI(13/63, width)/-2, hodograph = hodoPts), PerpAlongBez(12/63, ctlPts, dist = BezI(12/63, width)/-2, hodograph = hodoPts), PerpAlongBez(11/63, ctlPts, dist = BezI(11/63, width)/-2, hodograph = hodoPts), PerpAlongBez(10/63, ctlPts, dist = BezI(10/63, width)/-2, hodograph = hodoPts), PerpAlongBez(9/63, ctlPts, dist = BezI(9/63, width)/-2, hodograph = hodoPts), PerpAlongBez(8/63, ctlPts, dist = BezI(8/63, width)/-2, hodograph = hodoPts), PerpAlongBez(7/63, ctlPts, dist = BezI(7/63, width)/-2, hodograph = hodoPts), PerpAlongBez(6/63, ctlPts, dist = BezI(6/63, width)/-2, hodograph = hodoPts), PerpAlongBez(5/63, ctlPts, dist = BezI(5/63, width)/-2, hodograph = hodoPts), PerpAlongBez(4/63, ctlPts, dist = BezI(4/63, width)/-2, hodograph = hodoPts), PerpAlongBez(3/63, ctlPts, dist = BezI(3/63, width)/-2, hodograph = hodoPts), PerpAlongBez(2/63, ctlPts, dist = BezI(2/63, width)/-2, hodograph = hodoPts), PerpAlongBez(1/63, ctlPts, dist = BezI(1/63, width)/-2, hodograph = hodoPts), PerpAlongBez(0/63, ctlPts, dist = BezI(0/63, width)/-2, hodograph = hodoPts)
      ]);
    } else {
      polygon([
        PointAlongBez(0/63, ctlPts), PointAlongBez(1/63, ctlPts), PointAlongBez(2/63, ctlPts), PointAlongBez(3/63, ctlPts), PointAlongBez(4/63, ctlPts), PointAlongBez(5/63, ctlPts), PointAlongBez(6/63, ctlPts), PointAlongBez(7/63, ctlPts), PointAlongBez(8/63, ctlPts), PointAlongBez(9/63, ctlPts), PointAlongBez(10/63, ctlPts), PointAlongBez(11/63, ctlPts), PointAlongBez(12/63, ctlPts), PointAlongBez(13/63, ctlPts), PointAlongBez(14/63, ctlPts), PointAlongBez(15/63, ctlPts), PointAlongBez(16/63, ctlPts), PointAlongBez(17/63, ctlPts), PointAlongBez(18/63, ctlPts), PointAlongBez(19/63, ctlPts), PointAlongBez(20/63, ctlPts), PointAlongBez(21/63, ctlPts), PointAlongBez(22/63, ctlPts), PointAlongBez(23/63, ctlPts), PointAlongBez(24/63, ctlPts), PointAlongBez(25/63, ctlPts), PointAlongBez(26/63, ctlPts), PointAlongBez(27/63, ctlPts), PointAlongBez(28/63, ctlPts), PointAlongBez(29/63, ctlPts), PointAlongBez(30/63, ctlPts), PointAlongBez(31/63, ctlPts), PointAlongBez(32/63, ctlPts), PointAlongBez(33/63, ctlPts), PointAlongBez(34/63, ctlPts), PointAlongBez(35/63, ctlPts), PointAlongBez(36/63, ctlPts), PointAlongBez(37/63, ctlPts), PointAlongBez(38/63, ctlPts), PointAlongBez(39/63, ctlPts), PointAlongBez(40/63, ctlPts), PointAlongBez(41/63, ctlPts), PointAlongBez(42/63, ctlPts), PointAlongBez(43/63, ctlPts), PointAlongBez(44/63, ctlPts), PointAlongBez(45/63, ctlPts), PointAlongBez(46/63, ctlPts), PointAlongBez(47/63, ctlPts), PointAlongBez(48/63, ctlPts), PointAlongBez(49/63, ctlPts), PointAlongBez(50/63, ctlPts), PointAlongBez(51/63, ctlPts), PointAlongBez(52/63, ctlPts), PointAlongBez(53/63, ctlPts), PointAlongBez(54/63, ctlPts), PointAlongBez(55/63, ctlPts), PointAlongBez(56/63, ctlPts), PointAlongBez(57/63, ctlPts), PointAlongBez(58/63, ctlPts), PointAlongBez(59/63, ctlPts), PointAlongBez(60/63, ctlPts), PointAlongBez(61/63, ctlPts), PointAlongBez(62/63, ctlPts), PointAlongBez(63/63, ctlPts), PerpAlongBez(63/63, ctlPts, dist = BezI(63/63, width), hodograph = hodoPts), PerpAlongBez(62/63, ctlPts, dist = BezI(62/63, width), hodograph = hodoPts), PerpAlongBez(61/63, ctlPts, dist = BezI(61/63, width), hodograph = hodoPts), PerpAlongBez(60/63, ctlPts, dist = BezI(60/63, width), hodograph = hodoPts), PerpAlongBez(59/63, ctlPts, dist = BezI(59/63, width), hodograph = hodoPts), PerpAlongBez(58/63, ctlPts, dist = BezI(58/63, width), hodograph = hodoPts), PerpAlongBez(57/63, ctlPts, dist = BezI(57/63, width), hodograph = hodoPts), PerpAlongBez(56/63, ctlPts, dist = BezI(56/63, width), hodograph = hodoPts), PerpAlongBez(55/63, ctlPts, dist = BezI(55/63, width), hodograph = hodoPts), PerpAlongBez(54/63, ctlPts, dist = BezI(54/63, width), hodograph = hodoPts), PerpAlongBez(53/63, ctlPts, dist = BezI(53/63, width), hodograph = hodoPts), PerpAlongBez(52/63, ctlPts, dist = BezI(52/63, width), hodograph = hodoPts), PerpAlongBez(51/63, ctlPts, dist = BezI(51/63, width), hodograph = hodoPts), PerpAlongBez(50/63, ctlPts, dist = BezI(50/63, width), hodograph = hodoPts), PerpAlongBez(49/63, ctlPts, dist = BezI(49/63, width), hodograph = hodoPts), PerpAlongBez(48/63, ctlPts, dist = BezI(48/63, width), hodograph = hodoPts), PerpAlongBez(47/63, ctlPts, dist = BezI(47/63, width), hodograph = hodoPts), PerpAlongBez(46/63, ctlPts, dist = BezI(46/63, width), hodograph = hodoPts), PerpAlongBez(45/63, ctlPts, dist = BezI(45/63, width), hodograph = hodoPts), PerpAlongBez(44/63, ctlPts, dist = BezI(44/63, width), hodograph = hodoPts), PerpAlongBez(43/63, ctlPts, dist = BezI(43/63, width), hodograph = hodoPts), PerpAlongBez(42/63, ctlPts, dist = BezI(42/63, width), hodograph = hodoPts), PerpAlongBez(41/63, ctlPts, dist = BezI(41/63, width), hodograph = hodoPts), PerpAlongBez(40/63, ctlPts, dist = BezI(40/63, width), hodograph = hodoPts), PerpAlongBez(39/63, ctlPts, dist = BezI(39/63, width), hodograph = hodoPts), PerpAlongBez(38/63, ctlPts, dist = BezI(38/63, width), hodograph = hodoPts), PerpAlongBez(37/63, ctlPts, dist = BezI(37/63, width), hodograph = hodoPts), PerpAlongBez(36/63, ctlPts, dist = BezI(36/63, width), hodograph = hodoPts), PerpAlongBez(35/63, ctlPts, dist = BezI(35/63, width), hodograph = hodoPts), PerpAlongBez(34/63, ctlPts, dist = BezI(34/63, width), hodograph = hodoPts), PerpAlongBez(33/63, ctlPts, dist = BezI(33/63, width), hodograph = hodoPts), PerpAlongBez(32/63, ctlPts, dist = BezI(32/63, width), hodograph = hodoPts), PerpAlongBez(31/63, ctlPts, dist = BezI(31/63, width), hodograph = hodoPts), PerpAlongBez(30/63, ctlPts, dist = BezI(30/63, width), hodograph = hodoPts), PerpAlongBez(29/63, ctlPts, dist = BezI(29/63, width), hodograph = hodoPts), PerpAlongBez(28/63, ctlPts, dist = BezI(28/63, width), hodograph = hodoPts), PerpAlongBez(27/63, ctlPts, dist = BezI(27/63, width), hodograph = hodoPts), PerpAlongBez(26/63, ctlPts, dist = BezI(26/63, width), hodograph = hodoPts), PerpAlongBez(25/63, ctlPts, dist = BezI(25/63, width), hodograph = hodoPts), PerpAlongBez(24/63, ctlPts, dist = BezI(24/63, width), hodograph = hodoPts), PerpAlongBez(23/63, ctlPts, dist = BezI(23/63, width), hodograph = hodoPts), PerpAlongBez(22/63, ctlPts, dist = BezI(22/63, width), hodograph = hodoPts), PerpAlongBez(21/63, ctlPts, dist = BezI(21/63, width), hodograph = hodoPts), PerpAlongBez(20/63, ctlPts, dist = BezI(20/63, width), hodograph = hodoPts), PerpAlongBez(19/63, ctlPts, dist = BezI(19/63, width), hodograph = hodoPts), PerpAlongBez(18/63, ctlPts, dist = BezI(18/63, width), hodograph = hodoPts), PerpAlongBez(17/63, ctlPts, dist = BezI(17/63, width), hodograph = hodoPts), PerpAlongBez(16/63, ctlPts, dist = BezI(16/63, width), hodograph = hodoPts), PerpAlongBez(15/63, ctlPts, dist = BezI(15/63, width), hodograph = hodoPts), PerpAlongBez(14/63, ctlPts, dist = BezI(14/63, width), hodograph = hodoPts), PerpAlongBez(13/63, ctlPts, dist = BezI(13/63, width), hodograph = hodoPts), PerpAlongBez(12/63, ctlPts, dist = BezI(12/63, width), hodograph = hodoPts), PerpAlongBez(11/63, ctlPts, dist = BezI(11/63, width), hodograph = hodoPts), PerpAlongBez(10/63, ctlPts, dist = BezI(10/63, width), hodograph = hodoPts), PerpAlongBez(9/63, ctlPts, dist = BezI(9/63, width), hodograph = hodoPts), PerpAlongBez(8/63, ctlPts, dist = BezI(8/63, width), hodograph = hodoPts), PerpAlongBez(7/63, ctlPts, dist = BezI(7/63, width), hodograph = hodoPts), PerpAlongBez(6/63, ctlPts, dist = BezI(6/63, width), hodograph = hodoPts), PerpAlongBez(5/63, ctlPts, dist = BezI(5/63, width), hodograph = hodoPts), PerpAlongBez(4/63, ctlPts, dist = BezI(4/63, width), hodograph = hodoPts), PerpAlongBez(3/63, ctlPts, dist = BezI(3/63, width), hodograph = hodoPts), PerpAlongBez(2/63, ctlPts, dist = BezI(2/63, width), hodograph = hodoPts), PerpAlongBez(1/63, ctlPts, dist = BezI(1/63, width), hodograph = hodoPts), PerpAlongBez(0/63, ctlPts, dist = BezI(0/63, width), hodograph = hodoPts)
      ]);
    }
  }
}
module BezWall( 
  ctlPts, 
  width = 1, 
  height = 1, 
  steps = 16,
  widthCtls = [], 
  heightCtls = [], 
  centered = false, 
  showCtlR = 1
) {
  hodoPts = hodograph(ctlPts);
  if (showCtlR > 0) {
    for (pt = ctlPts) {
      % translate([pt[0], pt[1], 0]) circle(showCtlR);
    }
  }
  triangles = [ [0,2,1], [0,3,2], [0,4,5], [0,1,4], [0,6,3], [0,5,6], [4,6,5], [4,7,6], [1,2,7], [1,7,4], [2,3,6], [2,6,7], ];
  for(step = [steps-1 : 1])
  {
    assign(
      t1 = step/(steps-1), 
      t0 = (step-1)/(steps-1)
    ) {
    assign(
      hgt0 = len(heightCtls) > 0 ? BezI(t0, heightCtls) : height,
      hgt1 = len(heightCtls) > 0 ? BezI(t1, heightCtls) : height,
      wid0 = len(widthCtls) > 0 ? BezI(t0, widthCtls) : width, 
      wid1 = len(widthCtls) > 0 ? BezI(t1, widthCtls) : width
    ) {
      if (centered) {
        assign(
          p0 = PerpAlongBez(t0, ctlPts, dist = -wid0/2, hodograph = hodoPts),
          p1 = PerpAlongBez(t0, ctlPts, dist = wid0/2, hodograph = hodoPts),
          p4 = PerpAlongBez(t1, ctlPts, dist = wid1/2, hodograph = hodoPts),
          p5 = PerpAlongBez(t1, ctlPts, dist = -wid1/2, hodograph = hodoPts)
        ) {
          if (hgt0 == 0 && hgt1 == 0 ) {
            polygon([ p5, p0, p1, p4 ]);
          } else if (hgt0 == hgt1) {
            linear_extrude(height = hgt0, convexity = 2) polygon([ p5, p0, p1, p4 ]);
          } else {
            polyhedron(
              points =[
                [p0[0],p0[1],0], // 0
                [p1[0],p1[1],0], // 1
                [p1[0],p1[1],hgt0], // 2
                [p0[0],p0[1],hgt0], // 3
                [p4[0],p4[1],0], // 4
                [p5[0],p5[1],0], // 5
                [p5[0],p5[1],hgt1], // 6
                [p4[0],p4[1],hgt1], // 7
              ],
              triangles = triangles,
              convexity = 2
            );
          }
        }
      } else {
        assign(
          p0 = PointAlongBez(t0, ctlPts),
          p1 = PerpAlongBez(t0, ctlPts, dist = wid0, hodograph = hodoPts),
          p4 = PerpAlongBez(t1, ctlPts, dist = wid1, hodograph = hodoPts),
          p5 = PointAlongBez(t1, ctlPts)
        ) {
          if (hgt0 == 0 && hgt1 == 0 ) {
            polygon([ p5, p0, p1, p4 ]);
          } else if (hgt0 == hgt1) {
            linear_extrude(height = hgt0, convexity = 2) polygon([ p5, p0, p1, p4 ]);
          } else {
            polyhedron(
              points =[
                [p0[0],p0[1],0], // 0
                [p1[0],p1[1],0], // 1
                [p1[0],p1[1],hgt0], // 2
                [p0[0],p0[1],hgt0], // 3
                [p4[0],p4[1],0], // 4
                [p5[0],p5[1],0], // 5
                [p5[0],p5[1],hgt1], // 6
                [p4[0],p4[1],hgt1], // 7
              ],
              triangles = triangles,
              convexity = 2
            );
          }
        }
      }
    } }
  }
}

module BezArc(ctlPts, focalPoint, steps=12, height = 1, heightCtls = [], showCtlR = 1)
{
  if (showCtlR > 0) {
    for (pt = ctlPts) {
      % translate([pt[0], pt[1], 0]) circle(showCtlR);
    }
  }
  triangles = [
    [0,2,1],
    [3,4,5],
    [1,5,4],
    [2,5,1],
    [0,1,4],
    [0,4,3],
    [0,5,2],
    [0,3,5],
    ];
  for(step = [steps-1 : 1])
  {
    assign(
      t1 = step/(steps-1), 
      t0 = (step-1)/(steps-1),
      fp = [focalPoint[0], focalPoint[1], len(heightCtls) > 0 ? BezI(0, heightCtls) : height]
    ) {
    assign(
      hgt0 = len(heightCtls) > 0 ? BezI(t0, heightCtls) : height,
      hgt1 = len(heightCtls) > 0 ? BezI(t1, heightCtls) : height,
      p0 = PointAlongBez(t0, ctlPts), 
      p1 = PointAlongBez(t1, ctlPts)
    ) {
      if (hgt0 == 0 && hgt1 == 0 ) {
        polygon([ focalPoint, p0, p1 ]);
      } else if (hgt0 == hgt1 || false) {
        linear_extrude(height = hgt0, convexity = 2) polygon([ focalPoint, p0, p1 ]);
      } else {
        polyhedron( // not manifold
          points = [
            [focalPoint[0], focalPoint[1], 0],  // 0
            [p1[0], p1[1], 0],                  // 1
            [p0[0], p0[1], 0],                  // 2
            [focalPoint[0], focalPoint[1], hgt0], // 3
            [p1[0], p1[1], hgt1],               // 4
            [p0[0], p0[1], hgt0],               // 5
            [focalPoint[0], focalPoint[1], hgt1], // 6
          ],
          triangles = triangles,
          convexity = 2
        );
      }
    } }
  }
}
function PointAlongBez(t, ctlPts) = 
  len(ctlPts) == 1 ? PointAlongBez1(t, ctlPts) : 
  len(ctlPts) == 2 ? PointAlongBez2(t, ctlPts) : 
  len(ctlPts) == 3 ? PointAlongBez3(t, ctlPts) : 
  len(ctlPts) == 4 ? PointAlongBez4(t, ctlPts) : 
  len(ctlPts) == 5 ? PointAlongBez5(t, ctlPts) : 
  len(ctlPts) == 6 ? PointAlongBez6(t, ctlPts) : 
  len(ctlPts) == 7 ? PointAlongBez7(t, ctlPts) : 
  len(ctlPts) == 8 ? PointAlongBez8(t, ctlPts) :
  [];

function BezI(t, ctls) = 
  len(ctls) == 1 ? BezI1(t, ctls) : 
  len(ctls) == 2 ? BezI2(t, ctls) : 
  len(ctls) == 3 ? BezI3(t, ctls) : 
  len(ctls) == 4 ? BezI4(t, ctls) : 
  len(ctls) == 5 ? BezI5(t, ctls) : 
  len(ctls) == 6 ? BezI6(t, ctls) : 
  len(ctls) == 7 ? BezI7(t, ctls) : 
  len(ctls) == 8 ? BezI8(t, ctls) :
  [];

function PointAlongBez1(t, ctlPts) = [ 
  BezI1(t, [ctlPts[0][0]]), 
  BezI1(t, [ctlPts[0][1]]) 
];
function PointAlongBez2(t, ctlPts) = [ 
  BezI2(t, [ctlPts[0][0], ctlPts[1][0]]), 
  BezI2(t, [ctlPts[0][1], ctlPts[1][1]]) 
];
function PointAlongBez3(t, ctlPts) = [ 
  BezI3(t, [ctlPts[0][0], ctlPts[1][0], ctlPts[2][0]]), 
  BezI3(t, [ctlPts[0][1], ctlPts[1][1], ctlPts[2][1]]) 
];
function PointAlongBez4(t, ctlPts) = [ 
  BezI4(t, [ctlPts[0][0], ctlPts[1][0], ctlPts[2][0], ctlPts[3][0]]), 
  BezI4(t, [ctlPts[0][1], ctlPts[1][1], ctlPts[2][1], ctlPts[3][1]]) 
];
function PointAlongBez5(t, ctlPts) = [ 
  BezI5(t, [ctlPts[0][0], ctlPts[1][0], ctlPts[2][0], ctlPts[3][0], ctlPts[4][0]]), 
  BezI5(t, [ctlPts[0][1], ctlPts[1][1], ctlPts[2][1], ctlPts[3][1], ctlPts[4][1]]) 
];
function PointAlongBez6(t, ctlPts) = [ 
  BezI6(t, [ctlPts[0][0], ctlPts[1][0], ctlPts[2][0], ctlPts[3][0], ctlPts[4][0], ctlPts[5][0]]), 
  BezI6(t, [ctlPts[0][1], ctlPts[1][1], ctlPts[2][1], ctlPts[3][1], ctlPts[4][1], ctlPts[5][1]]) 
];
function PointAlongBez7(t, ctlPts) = [ 
  BezI7(t, [ctlPts[0][0], ctlPts[1][0], ctlPts[2][0], ctlPts[3][0], ctlPts[4][0], ctlPts[5][0], ctlPts[6][0]]), 
  BezI7(t, [ctlPts[0][1], ctlPts[1][1], ctlPts[2][1], ctlPts[3][1], ctlPts[4][1], ctlPts[5][1], ctlPts[6][1]]) 
];
function PointAlongBez8(t, ctlPts) = [ 
  BezI8(t, [ctlPts[0][0], ctlPts[1][0], ctlPts[2][0], ctlPts[3][0], ctlPts[4][0], ctlPts[5][0], ctlPts[6][0], ctlPts[7][0]]), 
  BezI8(t, [ctlPts[0][1], ctlPts[1][1], ctlPts[2][1], ctlPts[3][1], ctlPts[4][1], ctlPts[5][1], ctlPts[6][1], ctlPts[7][1]]) 
];

function PerpAlongBez(t, ctlPts, dist = 1, hodograph = []) = 
  len(ctlPts) == 2 ? PerpAlongBez2(t, ctlPts, dist, hodograph) : 
  len(ctlPts) == 3 ? PerpAlongBez3(t, ctlPts, dist, hodograph) : 
  len(ctlPts) == 4 ? PerpAlongBez4(t, ctlPts, dist, hodograph) : 
  len(ctlPts) == 5 ? PerpAlongBez5(t, ctlPts, dist, hodograph) : 
  len(ctlPts) == 6 ? PerpAlongBez6(t, ctlPts, dist, hodograph) : 
  len(ctlPts) == 7 ? PerpAlongBez7(t, ctlPts, dist, hodograph) : 
  len(ctlPts) == 8 ? PerpAlongBez8(t, ctlPts, dist, hodograph) :
  [];

function PerpAlongBez2(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez2(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez1( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );

function PerpAlongBez3(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez3(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez2( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );

function PerpAlongBez4(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez4(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez3( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );

function PerpAlongBez5(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez5(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez4( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );

function PerpAlongBez6(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez6(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez5( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );

function PerpAlongBez7(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez7(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez6( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );

function PerpAlongBez8(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez8(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez7( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );


function hodograph(p) = 
  len(p) == 2 ? 
    [ pDiff(p[1], p[0]) ] :  
  len(p) == 3 ? 
    [ pDiff(p[1], p[0]), pDiff(p[2], p[1]) ] :  
  len(p) == 4 ? 
    [ pDiff(p[1], p[0]), pDiff(p[2], p[1]), pDiff(p[3], p[2]) ] :  
  len(p) == 5 ? 
    [ pDiff(p[1], p[0]), pDiff(p[2], p[1]), pDiff(p[3], p[2]), pDiff(p[4], p[3]) ] :  
  len(p) == 6 ? 
    [ pDiff(p[1], p[0]), pDiff(p[2], p[1]), pDiff(p[3], p[2]), pDiff(p[4], p[3]), pDiff(p[5], p[4]) ] :  
  len(p) == 7 ? 
    [ pDiff(p[1], p[0]), pDiff(p[2], p[1]), pDiff(p[3], p[2]), pDiff(p[4], p[3]), pDiff(p[5], p[4]), pDiff(p[6], p[5]) ] :  
  len(p) == 8 ? 
    [ pDiff(p[1], p[0]), pDiff(p[2], p[1]), pDiff(p[3], p[2]), pDiff(p[4], p[3]), pDiff(p[5], p[4]), pDiff(p[6], p[5]), pDiff(p[7], p[6]) ] : 
  [];

function BezI1(t, ctls) =
  (ctls[0])
  ;

function BezI2(t, ctls) =
  ((1-t) * ctls[0]) +
  (t * ctls[1])
  ;

function BezI3(t, ctls) =
  (pow(1-t, 2) * ctls[0]) +
  (2 * t * (1-t) * ctls[1]) +
  (pow(t, 2) * ctls[2])
  ;

function BezI4(t, ctls) =
  (pow(1-t, 3) * ctls[0]) +
  (3 * t * pow(1-t, 2) * ctls[1]) +
  (3 * pow(t, 2) * (1-t) * ctls[2]) +
  (pow(t, 3) * ctls[3])
  ;

function BezI5(t, ctls) =
  (pow(1-t, 4) * ctls[0]) +
  (4 * t * pow(1-t, 3) * ctls[1]) +
  (6 * pow(t, 2) * pow(1-t, 2) * ctls[2]) +
  (4 * pow(t, 3) * (1-t) * ctls[3]) +
  (pow(t, 4) * ctls[4])
  ;

function BezI6(t, ctls) =
  (pow(1-t, 5) * ctls[0]) +
  (5 * t * pow(1-t, 4) * ctls[1]) +
  (10 * pow(t, 2) * pow(1-t, 3) * ctls[2]) +
  (10 * pow(t, 3) * pow(1-t, 2) * ctls[3]) +
  (5 * pow(t, 4) * (1-t) * ctls[4]) +
  (pow(t, 5) * ctls[5])
  ;

function BezI7(t, ctls) =
  (pow(1-t, 6) * ctls[0]) +
  (6 * t * pow(1-t, 5) * ctls[1]) +
  (15 * pow(t, 2) * pow(1-t, 4) * ctls[2]) +
  (20 * pow(t, 3) * pow(1-t, 3) * ctls[3]) +
  (15 * pow(t, 4) * pow(1-t, 2) * ctls[4]) +
  (6 * pow(t, 5) * (1-t) * ctls[5]) +
  (pow(t, 6) * ctls[6])
  ;

function BezI8(t, ctls) =
  (pow(1-t, 7) * ctls[0]) +
  (7 * t * pow(1-t, 6) * ctls[1]) +
  (21 * pow(t, 2) * pow(1-t, 5) * ctls[2]) +
  (35 * pow(t, 3) * pow(1-t, 4) * ctls[3]) +
  (35 * pow(t, 4) * pow(1-t, 3) * ctls[4]) +
  (21 * pow(t, 5) * pow(1-t, 2) * ctls[5]) +
  (7 * pow(t, 6) * (1-t) * ctls[6]) +
  (pow(t, 7) * ctls[7])
  ;

function x(p) = p[0];
function y(p) = p[1];
function dx(p1, p2) = x(p1) - x(p2);
function dy(p1, p2) = y(p1) - y(p2);
function sx(p1, p2) = x(p1) + x(p2);
function sy(p1, p2) = y(p1) + y(p2);

function dist(p1, p2 = [0,0]) = sqrt( pow( dx(p1,p2), 2) + pow( dy(p1,p2), 2) );
function normalize(p, n = 1) = pScale( p, n / dist( p ) );

function pSum(p1, p2) = [sx(p1, p2), sy(p1, p2)];
function pDiff(p1, p2) = [dx(p1, p2), dy(p1, p2)];
function pScale(p, v) = [x(p)*v, y(p)*v];

function rot90cw(p) = [y(p), -x(p)];
function rot90ccw(p) = [-y(p), x(p)];
function rot(p, a) = [
  x(p) * cos(a) - y(p) * sin(a),
  x(p) * sin(a) - y(p) * cos(a),
];
function rotAbout(p1, p2, a) = pSum(rot(pDiff(p1, p2), a), p2); // rotate p1 about p2
