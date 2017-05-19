//TODO
//- /move on back end
//- good answer for phase name
//- animate tile slide
//- /only move selected
//- problem selecting up
//- move up and down
//- /create
//- delete
$(function() {

  var LAST_KEY;

  var issueTemplate = '<div class="tile">' +
    '<div class="tile-container">' +
    '<input class="title" type="text">' +
    '<input class="author" type="text">' +
    '</div>' +
    '<div class="indicator"></div>' +
    '<textarea class="description"></textarea>' +
    '<input class="assignee" type="text">' +
    '<input class="submit" type="submit">' +
  '</div>';

  function intersectRect(r1, r2) {
    return !(r2.left > r1.right || 
      r2.right < r1.left || 
      r2.top > r1.bottom ||
      r2.bottom < r1.top);
  }

  // find neighboring tile
  function gridNeighbor(tile, dir) {
    if (!tile) {
      return;
    }
    var pos = $(tile).offset();
    var rect = {'width': $(tile).width(), 'height': $(tile).height()};
    console.debug(pos);
    var pretRect = {
      'top': pos.top, 
      'left': pos.left, 
      'right': pos.left + rect.width,
      'bottom': pos.top + rect.height
    };
    console.debug(dir);
    if (dir == 'left') {
      pretRect.top = pretRect.top + 40;
      pretRect.bottom = pretRect.bottom - 40;
      pretRect.left = pretRect.left - (rect.width - 40);
      pretRect.right = pretRect.right - (rect.width + 40);
    } else if (dir == 'right') {
      pretRect.top = pretRect.top + 40;
      pretRect.bottom = pretRect.bottom - 40;
      pretRect.left = pretRect.left + (rect.width + 40);
      pretRect.right = pretRect.right + (rect.width - 40);
    } else if (dir == 'up') {
      pretRect.top = pretRect.top - (rect.height - 40);
      pretRect.bottom = pretRect.bottom - (rect.height + 40);
      pretRect.left = pretRect.left + 40;
      pretRect.right = pretRect.right - 40;
    } else if (dir == 'down') {
      pretRect.top = pretRect.top + (rect.height + 40);
      pretRect.bottom = pretRect.bottom + (rect.height - 40);
      pretRect.left = pretRect.left + 40;
      pretRect.right = pretRect.right - 40;
    }
    var inter = $('.tile').filter(function(i, v) {
      var candidateTile = {
        'top': $(v).offset().top,
        'left': $(v).offset().left,
        'right': $(v).offset().left + $(v).width(),
        'bottom': $(v).offset().top + $(v).height()
      };
      return intersectRect(pretRect, candidateTile);
    })
    if (inter.length > 0) {
      return inter;
    } else {
      return [tile];
    };
  };

  function slide(tile, dir) {
    var targets = gridNeighbor(tile, dir);
    if ($(targets[0]).data().id == $(tile).data().id) {
      console.debug('nope');
      var col = '#' + $(tile).parent().parent().attr('id');
      var oldPhase = $(col).find('.headlet').text().toLowerCase()
      var destCol = newCol(col, dir) + ' .col-container';
      var newPhase = $(newCol(col, dir)).find('.headlet').text().toLowerCase();
    //actual move
      $(tile).clone(true).appendTo($(destCol));
    } else {
      if ($(targets[0]).offset().top < (tile.offset().top + (tile.height() / 2)))
      {
        $(tile).clone(true).insertBefore(targets[0]);
      } else {
        $(tile).clone(true).insertAfter(targets[0]);
      }
    }
    $(tile).remove();
  };

  function newCol(colString, dir)
  {
    if (colString == '#col0' && dir == 'left' || colString == '#col3' && dir == 'right')
    {
      console.log("can't move");
      return '#' + colString
    }
    else
    {
      var a = parseInt(colString.slice(-1));
      if (dir == 'left')
      {
        return '#col' + (a - 1);
      }
      else
      {
        return '#col' + (a + 1);
      }
    }
  };

  function countLines(text)
  {
    var count = (text.match(/[\r\n]/g) || []).length;
    return count;
  };

  function edit(tile)
  {
    var dObj = $(tile).data();
    var desc = $(tile).find('.description').val();
    var pha = $(tile).parent().parent().find('.headlet').text().toLowerCase();


    window.urb.send({
      'action': 'edit-issue',
      'host': '~rosfet-ronlyn-mirdel-sillev--satnes-haphul-habryg-loppeg',
      'board': 'testproj',
      'phase': pha,
      'description': generateIssue(dObj) + desc,
      'issue': dObj['id']
    }, function(d) {
      console.debug(d);
    });
  };

  //move tile right or left
  function move(tile, dir)
  {
    console.log('movin');
    var col = '#' + $(tile).parent().parent().attr('id');
    var oldPhase = $(col).find('.headlet').text().toLowerCase()
    var destCol = newCol(col, dir) + ' .col-container';
    var newPhase = $(newCol(col, dir)).find('.headlet').text().toLowerCase();
    //actual move
    //$(tile).clone(true).prependTo($(destCol));
    var issueData = $(tile).data();
    // move on back end
    window.urb.send({
      'action': 'change-phase',
      'host': '~rosfet-ronlyn-mirdel-sillev--satnes-haphul-habryg-loppeg',
      'board': 'testproj',
      'from-phase': oldPhase,
      'to-phase': newPhase,
      'issue': issueData['id']
    }, function(d) {
      console.debug(d);
    });
    //$(tile).remove();
    slide(tile, dir);
    return;
  }

    function contract(tile) {
      $(tile).removeClass('expanded');
      //$(tile).find('.description').attr('readonly', 'readonly');
      $('.bumped').css('margin-top', 0);
    };
    function expand(tile, dir) {
      var col = $(tile).parent().parent().attr('id');
      var rect = {
        top: $(tile).offset().top,
        left: $(tile).offset().left,
        right: $(tile).offset().left + (2 * $(tile).width()),
        bottom: ($(tile).offset().top + 600)
      };

      var inter = $('.tile').filter(function(i, v) {
        if ($(v).parent().parent().attr('id') == col) {
          return false;
        }
        var candidateTile = {
          'top': $(v).offset().top,
          'left': $(v).offset().left,
          'right': $(v).offset().left + $(v).width(),
          'bottom': $(v).offset().top + $(v).height()
        };
        return intersectRect(rect, candidateTile);
      })
      console.debug(inter);

      $(inter[0]).addClass('bumped').css('margin-top', '630px'); // this will have to be customized
      $(tile).addClass('expanded');
     // $(tile).find('.description').attr('readonly', '');
      //determine expanded size
      //find overlapping nodes
      //in neighboring cols, up margin to create space
    };
    
    function generateIssue(dObj)
    {
      return "---\r" +
      "author: '" + dObj['author'] + "'\r" +
      "assignee: '" + dObj['assignee'] + "'\r" +
      "title: '" + dObj['title'] + "'\r" +
      "---'\r"
    };

    function parseIssue(d)
    {
      var contents = d[1][0][1];
      console.debug(contents);
      //make this a function
      var title = /title: '(.*)'[\r\n]/.exec(contents);
      var author = /author: '(.*)'[\r\n]/.exec(contents);
      var assignee = /assignee: '(.*)'[\r\n]/.exec(contents);
      var cleaned = contents.replace(/\-\-\-[\s\S]*\-\-\-[\s\S]/,'');

      return {
        'title': title[1],
        'author': author[1],
        'assignee': assignee[1],
        'description': cleaned.trim()
      };
    };

    function initializeUi(d)
    {
      if (d.data.length > 1)
      {
        //sort these columns
        $.each(d.data, function(i, v) {
          var dest = $('#col' + i);
          var head = $('<div class="headlet">' + v[0].toUpperCase() + '</div>')
          var cont = dest.find('.col-container'); 
          dest.prepend(head);
          $.each(v[1], function(j, q) {
            var a = $(issueTemplate)
            cont.prepend(a);
            var issueObj = parseIssue(q);
            a.find('.title').val(issueObj['title']);
            a.find('.author').val(issueObj['author']);
            a.find('.assignee').val(issueObj['assignee']);
            a.find('.description').text(issueObj['description']);
            var lines = countLines(issueObj['description']);
            if (lines < 2)
            {
              a.addClass('one');
            } else if (lines >= 2 && lines < 7)
            {
              a.addClass('two');
            } else
            {
              a.addClass('three');
            }
            a.data({'id': q[0],
              'title': issueObj['title'],
              'author': issueObj['author'],
              'assignee': issueObj['assignee']
            });
          });
        });
      }
    };

  window.urb.appl = "taskk"
  window.urb.bind('/sub-path',
    function(err,dat) {
      initializeUi(dat);
      $($('.tile')[0]).addClass('active');

      $('.title').click(function(e) {
        if (!$(this).parent().parent().hasClass('expanded')) {
          expand($(this).parent().parent(), 'right');
        } else {
          contract($(this).parent().parent())
        }
      });

      $('.submit').click(function(e) {
        edit($(this).parent());
      });

      $(window).keydown(function(e) {

        if (e.timeStamp == LAST_KEY) {
          return;
        }
        LAST_KEY = e.timeStamp;
        console.debug(LAST_KEY);
        var activeTile = $('.tile.active');
        if (e.shiftKey) 
        {
          if (e.keyCode == 37)
          {
            move(activeTile, 'left');
          } else if (e.keyCode == 39) {
            move(activeTile, 'right');
          }
        }
        if (e.keyCode == 37) {
          var newActive = gridNeighbor(activeTile, 'left')[0]
          $(activeTile).removeClass('active');
          $(newActive).addClass('active');
        } else if (e.keyCode == 38) {
          var newActive = gridNeighbor(activeTile, 'up')[0];
          $(activeTile).removeClass('active');
          $(newActive).addClass('active');
        } else if (e.keyCode == 39) {
          var newActive = gridNeighbor(activeTile, 'right')[0];
          $(activeTile).removeClass('active');
          $(newActive).addClass('active');
        } else if (e.keyCode == 40) {
          var newActive = gridNeighbor(activeTile, 'down')[0];
          $(activeTile).removeClass('active');
          $(newActive).addClass('active');
        }
      });
    }
  )
  window.urb.send({
      action: 'request-board',
      host: '~rosfet-ronlyn-mirdel-sillev--satnes-haphul-habryg-loppeg',
      board: 'testproj'
  });

})
