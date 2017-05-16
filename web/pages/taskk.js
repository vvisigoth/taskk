//TODO
//- move on back end
//- good answer for phase name
//- animate tile slide
$(function() {

  var issueTemplate = '<div class="tile">' +
    '<div class="tile-container">' +
    '<div class="title"></div>' +
    '<div class="author"></div>' +
    '</div>' +
    '<div class="indicator"></div>' +
    '<div class="description"></div>' +
    '<div class="assignee"></div>' +
  '</div>';

  //given coordinates and rect, which node is in?
  function checkTarget(y, h, destCol)
  {
    // get list of adjacent tiles that overlap
    // 
    return;
  }

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

  //move tile right or left
  function move(tile, dir)
  {
    console.log('movin');
    var col = '#' + $(tile).parent().parent().attr('id');
    var oldPhase = $(col).find('.headlet').text().toLowerCase()
    var destCol = newCol(col, dir) + ' .col-container';
    var newPhase = $(newCol(col, dir)).find('.headlet').text().toLowerCase();
    $(tile).clone(true).prependTo($(destCol));
    var issueData = $(tile).data();
    // move on back end
    window.urb.send({
        'action': 'change-phase',
        'host': '~rosfet-ronlyn-mirdel-sillev--satnes-haphul-habryg-loppeg',
        'board': 'testproj',
        'from-phase': oldPhase,
        'to-phase': newPhase,
        'issue': issueData['id']
    });
    $(tile).remove();
    return;
  }

    function parseIssue(d)
    {
      var contents = d[1][0][1];
      //make this a function
      var title = /title: '(.*)'[\r\n]/.exec(contents);
      var author = /author: '(.*)'[\r\n]/.exec(contents);
      var assignee = /assignee: '(.*)'[\r\n]/.exec(contents);
      var cleaned = contents.replace(/\-\-\-[\s\S]*\-\-\-[\s\S]/,'');
      return {
        'title': title[1],
        'author': author[1],
        'assignee': assignee[1],
        'description': cleaned
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
                  a.find('.title').text(issueObj['title']);
                  a.find('.author').text(issueObj['author']);
                  a.find('.assignee').text(issueObj['assignee']);
                  a.find('.description').text(issueObj['description']);
                  var lines = countLines(issueObj['description']);
                  if (lines < 3)
                  {
                    a.addClass('one');
                  } else if (lines >= 3 && lines < 8)
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
                  if (j == 0) {
                      a.addClass("bottom");
                  }
              });
          });
        }
    };

  window.urb.appl = "taskk"
  window.urb.bind('/sub-path',
    function(err,dat) {
      initializeUi(dat);
      $('.tile').on('click', function(e) {
        $('.tile').removeClass('active');
        $(this).addClass('active');
        move(this, 'right');
      });
    }
  )
  window.urb.send({
      action: 'request-board',
      host: '~rosfet-ronlyn-mirdel-sillev--satnes-haphul-habryg-loppeg',
      board: 'testproj'
  });

})
