//TODO
//- /move on back end
//- move up and down
//- new
//- delete
//- /only move selected
//- problem selecting up
//- /create
//- good answer for phase name
//- animate tile slide
//- weird line breaks in edited issues
$(function() {

  var url = window.location.href;
  var urlData = /#(.*)\/(.*)$/.exec(url)

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

  //given: phase
  //send to urbit
  function newIssue(pha) {
    window.urb.send({
      'action': 'create-issue',
      'host': urlData[1],
      'phase': pha.toLowerCase(),
      'board': urlData[2],
      'temp-id': Math.round(Math.random() * 100),
      'title': 'New Issue',
      'description': 'Describe issue here',
      'author': window.urb.user,
      'assignee': window.urb.user
  }, function(d) {
    console.debug('new issue callback');
    console.debug(d);
  })
  };

  // takes a data obj and returns a dom node
  function createTile(dobj) {
    var a = $(issueTemplate)
    //var issueObj = parseIssue(dobj);
    a.find('.title').val(dobj['title']);
    a.find('.author').val(dobj['author']);
    a.find('.assignee').val(dobj['assignee']);
    a.find('.description').text(dobj['description']);
    var lines = countLines(dobj['description']);
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
    a.data({'id': dobj['id'],
      'title': dobj['title'],
      'author': dobj['author'],
      'assignee': dobj['assignee']
    });
    return a
  };

  function slide(tile, dir) {
    var targets = gridNeighbor(tile, dir);
    if ($(targets[0]).data().id == $(tile).data().id) {
      var col = '#' + $(tile).parent().parent().attr('id');
      var oldPhase = $(col).find('.headlet .headlet-container').text().toLowerCase()
      var destCol = newCol(col, dir) + ' .col-container';
      var newPhase = $(newCol(col, dir)).find('.headlet .headlet-container').text().toLowerCase();
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
    var pha = $(tile).parent().parent().find('.headlet .headlet-container').text().toLowerCase();

    window.urb.send({
      'action': 'edit-issue',
      'host': '~rosfet-ronlyn-mirdel-sillev--satnes-haphul-habryg-loppeg',
      'board': 'testproj',
      'phase': pha,
      'description': generateIssue(dObj) + desc,
      'issue': dObj['id']
    }, function(d) {
      contract()
    });
  };

  //move tile right or left
  function move(tile, dir)
  {
    var col = '#' + $(tile).parent().parent().attr('id');
    var oldPhase = $(col).find('.headlet .headlet-container').text().toLowerCase()
    var destCol = newCol(col, dir) + ' .col-container';
    var newPhase = $(newCol(col, dir)).find('.headlet .headlet-container').text().toLowerCase();
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
      console.debug('callback from phase change');
    });
    //$(tile).remove();
    slide(tile, dir);
    return;
  }

    function contract() {
      $('.tile').removeClass('expanded');
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
      console.debug(d);

      var contents = d[1][0][1];
      //make this a function
      var title = /title: '(.*)'[\r\n]/.exec(contents);
      var author = /author: '(.*)'[\r\n]/.exec(contents);
      var assignee = /assignee: '(.*)'[\r\n]/.exec(contents);
      var cleaned = contents.replace(/\-\-\-[\s\S]*\-\-\-[\s\S]/,'');

      return {
        'id': d[0],
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
          //to catch bizarre bug
          //TODO figure this out
          if (v[0][1] != "T") {
            var dest = $('#col' + v[0][0]);
            dest.addClass(v[0]);
            var head = $('<div class="headlet">' + 
              '<div class="headlet-container">' +
              v[0].toUpperCase() + 
              '</div>' +
              '<div class="add-button">+</div>' +
              '</div>')
            var cont = dest.find('.col-container'); 
            dest.prepend(head);
            $.each(v[1], function(j, q) {
              console.debug(q);
              var d = parseIssue(q)
              console.debug(d);
              cont.prepend(createTile(d));
            });
          }
        });
      }
    };

  window.urb.appl = "taskk"
  window.urb.bind('/sub-path',
    function(err,dat) {
      console.debug('incoming on sub-path');
      console.debug(dat);

      if (dat.data['action-completed']) {
        console.debug('calling create tile');

        var d = dat.data['action-completed'];
        d['id'] = dat.data['issue-id'];
        var t = createTile(d);
        // insert on ui
        $('.' + d['phase']).find('.col-container').prepend(t);
      };
      initializeUi(dat);

      $($('.tile')[0]).addClass('active');

      $('.title').click(function(e) {
        if (!$(this).parent().parent().hasClass('expanded')) {
          expand($(this).parent().parent(), 'right');
        } else {
          contract($(this).parent().parent())
        }
      });

      $('.add-button').click(function(e) {
        var pha = $(this).parent().find('.headlet-container').text();

        newIssue(pha)
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
      host: urlData[1],
      board: urlData[2]
  });

})
