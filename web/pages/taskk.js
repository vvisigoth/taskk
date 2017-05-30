//TODO
//- move up and down
//- delete
//- problem selecting up
//- animate tile slide
//- weird line breaks in edited issues
$(function() {
  //GLOBALS 


  var url = window.location.href;
  var urlData = /#(.*)\/(.*)$/.exec(url);

  var HOST = urlData[1];
  var BOARD = urlData[2];

  var PHASE_INDEX = ['todo', 'doin', 'show', 'done'];

  var LAST_KEY;
  var INITIALIZED = false;

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

  // Add a new issue
  $('.add-button').on('click', function(e) {
    $('#empty-message').css('display', 'none');
    var pha = $(this).parent().find('.headlet-container').text();

    newIssue(pha)
  });


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
    var col = '#' + $(tile).parent().parent().attr('id');
    var pos = $(tile).offset();
    var rect = {'width': $(tile).width(), 'height': $(tile).height()};
    console.debug(pos);
    var pretRect = {
      'top': pos.top, 
      'left': pos.left, 
      'right': pos.left + rect.width,
      'bottom': pos.top + rect.height
    };

    // check if we're about to go off the board
    if (col == '#col0' && dir == 'left') {
      return [tile]
    } else if (col == '#col3' && dir == 'right') {
      return [tile]
    }

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
      // found a neighbor
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
      'host': HOST,
      'phase': pha.toLowerCase(),
      'board': BOARD,
      'temp-id': Math.round(Math.random() * 100),
      'title': 'New Issue',
      'description': 'Describe issue here',
      'author': '~' + window.urb.user,
      'assignee': '~' + window.urb.user
  }, function(d, x) {
    console.debug('new issue callback');
    console.debug(d);
    console.debug(x);
  })
  };

  function assignTileSize(tile, text) {

    $(tile).removeClass('one two three');

    var lines = countLines(text);

    if (lines < 2)
    {
      tile.addClass('one');
    } else if (lines >= 2 && lines < 7)
    {
      tile.addClass('two');
    } else
    {
      tile.addClass('three');
    }
    return tile
  };

  // takes a data obj and returns a dom node
  function createTile(dobj) {
    var a = $(issueTemplate)
    //var issueObj = parseIssue(dobj);
    a.find('.title').val(dobj['title']);
    a.find('.author').val(dobj['author']);
    a.find('.assignee').val(dobj['assignee']);
    a.find('.description').text(dobj['description']);
    a.data({'id': dobj['id'],
      'title': dobj['title'],
      'author': dobj['author'],
      'assignee': dobj['assignee']
    });

    $('#empty-message').css('display', 'none');

    return assignTileSize(a, dobj['description']);
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
    var author = $(tile).find('.author').val()
    var title = $(tile).find('.title').val();
    var pha = $(tile).parent().parent().find('.headlet .headlet-container').text().toLowerCase();

    dObj['title'] = title;
    dObj['author'] = author;

    var yaml = generateIssue(dObj)

    assignTileSize(tile, desc);

    window.urb.send({
      'action': 'edit-issue',
      'host': HOST,
      'board': BOARD,
      'phase': pha,
      'description': yaml + desc,
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
      'host': HOST,
      'board': BOARD,
      'from-phase': oldPhase,
      'to-phase': newPhase,
      'issue': issueData['id']
    }, function(d) {
      console.debug('callback from phase change');
    });
    //$(tile).remove();
    slide(tile, dir);
    return;
  };

  function contract() {
    $('.tile').removeClass('expanded');
    //$(tile).find('.description').attr('readonly', 'readonly');
    var ogMar = $('.bumped').data('og-margin');

    console.debug(ogMar);

    if (ogMar) {
      $('.bumped').css('margin-top', ogMar);
    } else {
      $('.bumped').css('margin-top', '');
    }
    $('.description').blur()
    $('.tile').removeClass('bumped');
  };

  function expand(tile) {
    var col = $(tile).parent().parent().attr('id');
    console.debug(col);

    if (col != 'col3') {
      var rect = {
        top: $(tile).offset().top,
        left: $(tile).offset().left,
        right: $(tile).offset().left + (2 * $(tile).width()),
        bottom: ($(tile).offset().top + 600)
      };
    } else {
      var rect = {
        top: $(tile).offset().top,
        left: $(tile).offset().left - $(tile).width(),
        right: $(tile).offset().right,
        bottom: ($(tile).offset().top + 600)
      };
    }

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

    contract();

    if (inter.length > 0) {
      var diff = $(tile).offset().top - $(inter[0]).offset().top;

      $(tile).data('og-margin', $(tile).css('margin-top'));

      console.debug($(tile).data());

      var bumpAmt = diff > 0 ? 630 + diff : 630;

      $(inter[0]).addClass('bumped').css('margin-top', bumpAmt + 'px');
    }

    $(tile).addClass('expanded');
    $(tile).find('.description').focus();
  };
    
  function generateIssue(dObj) {
    return "---\r" +
    "author: '" + dObj['author'] + "'\r" +
    "assignee: '" + dObj['assignee'] + "'\r" +
    "title: '" + dObj['title'] + "'\r" +
    "---'\r"
  };

  function parseIssue(d) {
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

  function initializeUi(d) {
      var boardObj = {};

      $.each(d.data, function(k, q) {
        boardObj[q[0]] = q[1];
      });

      console.debug(boardObj);

      //sort these columns
      for (var i=0; i < PHASE_INDEX.length; i++) {

        var cont = $('#col' + i + ' .col-container');

          // What if board has some empty cols?
          if (boardObj[PHASE_INDEX[i]]) {

            for (var j = 0; j < boardObj[PHASE_INDEX[i]].length; j++) {
              console.debug(boardObj[PHASE_INDEX[i]]);

              var tempObj = boardObj[PHASE_INDEX[i]][j];
              var d = parseIssue(tempObj);
              cont.prepend(createTile(d));
            }

          }
      }
    INITIALIZED = true;
  };

  function moveSelect(activeTile, dir)
  {
    var col = '#' + $(activeTile).parent().parent().attr('id');

    // don't escape board
    if ((col == '#col0' && dir == 'left') || (col == '#col3' && dir == 'right')) {
      console.debug('dont spill');
      return
    }
    var newActive = gridNeighbor(activeTile, dir)[0]
      // no neighbor
    if (newActive == activeTile) {
      console.debug('nowhere to go');

      if (dir =='left' || dir =='right') {
        // neighbor column
        var nc = newCol(col, dir);
        // check for empty column
        if ($(nc + ' .tile').length < 1) {
          var destCol = newCol(newCol(col, dir), dir);
          //we're safe from going off the board, so go nuts
          newActive = $(destCol + ' .tile')[0];
        } 
      }
    }
    $(activeTile).removeClass('active');
    $(newActive).addClass('active');
  };

  //KEY SHORTCUTS

  $(window).keydown(function(e) {


    console.debug(e);

    // EAT DOUBLE PRESS
    if (e.timeStamp == LAST_KEY) {
      return;
    }

    LAST_KEY = e.timeStamp;


    var activeTile = $('.tile.active');

    if (e.shiftKey && e.ctrlKey) 
    {
      if (e.keyCode == 37)
      {
        move(activeTile, 'left');
      } else if (e.keyCode == 39) {
        move(activeTile, 'right');
      } else if (e.keyCode == 65) {
        var pha = $(activeTile).parent().parent().find('.headlet-container').text();
        newIssue(pha)
      }
    }

    if (e.ctrlKey) {

      if (e.keyCode == 37) {
        moveSelect(activeTile, 'left');
      } else if (e.keyCode == 38) {
        moveSelect(activeTile, 'up');
      } else if (e.keyCode == 39) {
        moveSelect(activeTile, 'right');
      } else if (e.keyCode == 40) {
        moveSelect(activeTile, 'down');
      } else if (e.keyCode == 13) {
        if (!$(activeTile).hasClass('expanded')) {
          expand($(activeTile));
        } else {
          contract($(activeTile));
        }
      }

    }

  });

  window.urb.appl = "taskk"

  window.urb.bind('/sub-path',
    function(err,dat) {

      console.debug("on sub path");
      console.debug(dat);

      //Called if new issue has succeeded
      if (dat.data['action-completed']) {

        var d = dat.data['action-completed'];
        d['id'] = dat.data['issue-id'];
        var t = createTile(d);
        // insert on ui
        $('.' + d['phase']).find('.col-container').prepend(t);
        $('.tile').removeClass('active');
        $(t).addClass('active');
      };

      // request board came back fine
      if (dat.data.length > 0 && !INITIALIZED) {

        initializeUi(dat);

        $($('.tile')[0]).addClass('active');

      } else if (dat.data.length == 0) {
        // Start a new board!
        $('#empty-message').text("looks like there's no board here. create issues to start one.");
      }

    //HANDLERS

    // Expand/edit
    /*
    $('.tile').on('dblclick', function(e) {
      if (!$(this).parent().parent().hasClass('expanded')) {
        expand($(this).parent().parent());
      } else {
        contract($(this).parent().parent())
      }
    });
    */

    $('.submit').on('click', function(e) {
      console.debug('submit clicked');

      edit($(this).parent());
    });

  });

  // Send first request to kick off board load
  window.urb.send({
      action: 'request-board',
      host: HOST,
      board: BOARD
  });

})
