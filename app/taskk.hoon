::
::
::::  
  ::
  :: TODO
  :: - delete issue
  ::
/?    310
|%
  ++  card  
    $%  {$info wire @p toro}                     :: write to clay
        {$warp wire sock riff}                   :: watch a dir
        {$diff mark *}                           :: update subscribers
    ==
  ++  move  {bone card}                          ::
  ++  issu  
    $:  
      hos/(unit json) 
      boa/(unit json) 
      pha/(unit json) 
      iss/(unit json) 
      tit/(unit json) 
      des/(unit json) 
      aut/(unit json) 
      ass/(unit json)
    ==
    ::
--                                               ::
!:                                               ::
|_  {hid/bowl subp/path}                         ::
++  create-issue
  |=  jon/json
  ^-  (list move)
  =/  pj/issu  (proc-json jon)
  =/  id/@tas
    (scot %da now.hid)
  =/  pax/path
    /(scot %p our.hid)/home/(scot %da now.hid)/app/taskk/(scot %tas (jtape hos.pj))/(scot %tas (jtape boa.pj))/(scot %tas (jtape pha.pj))/(scot %da now.hid)/md
  =/  txt
    %-  crip
    """
    ---
    author: {<(jtape aut.pj)>}
    assignee: {<(jtape ass.pj)>}
    title: {<(jtape tit.pj)>}
    ---
    {<(jtape des.pj)>}
    """
  =/  ca/card
    :^
      %info
      /writing
      our.hid
      (foal pax [%md !>(txt)])
  =/  car/card
    :+
      %diff 
      %json 
      %-
        jobe 
        :~
          ['action-completed' (jape "create-issue")] 
          ['issue-id' (jape (trip id))]
          ['response-data' jon]
        ==
  =/  out
    %+  turn  (prey subp hid)
      |=  {o/bone *}
      [o car]
  (welp out ~[[ost.hid ca]])
::
::  edit an existing issue
++  edit-issue
  |=  jon/json
  ^-  (list move)
  =/  pj/issu  (proc-json jon)
  =/  pax/path
    /(scot %p our.hid)/home/(scot %da now.hid)/app/taskk/(scot %tas (jtape hos.pj))/(scot %tas (jtape boa.pj))/(scot %tas (jtape pha.pj))/(scot %tas (jtape iss.pj))/md

  =/  ca/card
    :^
      %info
      /writing
      our.hid
      (foal pax [%md !>((scot %tas (jtape des.pj)))])
  [[ost.hid ca] ~]
  ::
::  delete issue
++  delete-issue
  |=  jon/json
  ~&  %delete-issue-called
  ^-  (list move)
  ?.  ?=($o -.jon)
    [[ost.hid %diff %json ~] ~]
    ::
  =/  pj/issu  (proc-json jon)
  =/  phn  (~(got by p.jon) 'phase')
  =/  phan  ?:  ?=($s -.phn)  p.phn  ~
  =/  inp/path
    :~
      (scot %p our.hid)
      %home
      (scot %da now.hid)
      %app
      %taskk
      (scot %tas (jtape hos.pj))
      (scot %tas (jtape boa.pj))
      (scot %tas phan)
      (scot %tas (jtape iss.pj))
      %md
    ==
  =/  ca/card
    :^
      %info
      /deleting
      our.hid
      (fray inp)
  [[ost.hid ca] ~]
::
::  change board phase
++  change-phase
  |=  jon/json
  ~&  %change-phase-called
  ^-  (list move)
  ?.  ?=($o -.jon)
    [[ost.hid %diff %json ~] ~]
    ::
  =/  pj/issu  (proc-json jon)
  =/  phn  (~(got by p.jon) 'from-phase')
  =/  phan  ?:  ?=($s -.phn)  p.phn  ~
  =/  pht  (~(got by p.jon) 'to-phase')
  =/  phat  ?:  ?=($s -.pht)  p.pht  ~
  =/  inp/path
    :~
      (scot %p our.hid)
      %home
      (scot %da now.hid)
      %app
      %taskk
      (scot %tas (jtape hos.pj))
      (scot %tas (jtape boa.pj))
      (scot %tas phan)
      (scot %tas (jtape iss.pj))
      %md
    ==
  =/  out/path
    :~
      (scot %p our.hid)
      %home
      (scot %da now.hid)
      %app
      %taskk
      (scot %tas (jtape hos.pj))
      (scot %tas (jtape boa.pj))
      (scot %tas phat)
      (scot %tas (jtape iss.pj))
      %md
    ==
  =/  ca/card
    :^
      %info
      /moving
      our.hid
      %+  furl
        (fray inp)
        (foal out [%md !>(.^(* %cx inp))])
  [[ost.hid ca] ~]
::  request a board
++  request-board
  |=  jon/json
  ^-  (list move)
  =/  pj  (proc-json jon)
  ?.  ?=($o -.jon)
    [[ost.hid %diff %json ~] ~]
  =/  pax  (create-path [`@t`(jtape hos.pj) `@t`(jtape boa.pj) ~ ~])
  =/  car/card
    :+
      %diff
      %json
      %-
        jobe
        :~
          ['action-completed' (jape "request-board")]
          ['response-data' (crawl-path pax)]
        ==
  %+  turn  (prey subp hid)
    |=  {o/bone *}
    [o car]
::
::  process json string
++  jtape
  |=   a/(unit json)  
    ?~  a 
      ~ 
      ?:  ?=($s -.u.a)  
        p.u.a
        ~

::  process json
++  proc-json
  |=  jon/json
  ^-  issu
  ?.  ?=($o -.jon)
    [~ ~ ~ ~ ~ ~ ~ ~]
  =/  ho  (~(get by p.jon) 'host')
  =/  bo  (~(get by p.jon) 'board')
  =/  ph  (~(get by p.jon) 'phase')
  =/  ti  (~(get by p.jon) 'title')
  =/  de  (~(get by p.jon) 'description')
  =/  au  (~(get by p.jon) 'author')
  =/  is  (~(get by p.jon) 'issue')
  =/  as  (~(get by p.jon) 'assignee')
  :*
    ho 
    bo 
    ph 
    is 
    ti 
    de 
    au 
    as
  ==

::  create a path
++  create-path
  |=  {host/@t board/@t phase/(unit @t) issue/(unit @t)}
  ^-  path
  ?~  phase
    :~
      (scot %p our.hid)
      %home
      (scot %da now.hid)
      %app
      %taskk
      (scot %tas host)
      (scot %tas board)
    ==
  :~
    (scot %p our.hid)
    %home
    (scot %da now.hid)
    %app
    %taskk
    (scot %tas host)
    (scot %tas board)
    (scot %tas (need phase))
    (scot %tas (need issue))
    %md
  ==
::
::  for testing watch
++  poke-path
  |=  p/path
  ^-  (list move)
  (watch-dir p)
::
++  poke-json
  |=  jin/json
  ^-  (quip move +>.$)
  ?.  ?=($o -.jin)
    ~&(%whoops !!)
      ::[ost.hid (joba 'error' (jape "problem"))]
  =/  a  (~(got by p.jin) 'action')
  =/  act  ?:  ?=($s -.a)  p.a  ~
  :: logic to determine which action is being requested
  :: TODO use switch/case here
  =/  mo/(list move)
    ?:  =(act 'create-issue')
      (create-issue jin)
      ?:  =(act 'change-phase')  
        (change-phase jin)
        ?:  =(act 'edit-issue')  
          (edit-issue jin)
          ?:  =(act 'delete-issue')  
            (delete-issue jin)
        (request-board jin)
  :_  +>.$
  mo
::
++  crawl-path
  |=  pax/path
  |-  ^-  json
  =+  a=.^(arch cy+pax)
  ?~  fil.a
    :-  %a
      %+  turn
        (sort (~(tap by dir.a)) aor)
        |=  {p/@t $~}
          [%a [[%s p] (crawl-path (welp pax /[p])) ~]]
  =+  txt=.^(@t cx+pax)
  :: leaves should be a different data structure
  [%s txt]
::
::  subscribe to taskk front end
::
++  peer
  |=  pax/path
  ~&  [%subscribed-to pax]
  =/  lism/(list move)
    (watch-dir (welp /app/taskk pax))
  =/  jon/json
    %-
      jobe 
      :~
        ['action-completed' (jape "connect")]
      ==
  [(welp lism [[ost.hid %diff %json jon] ~]) +>.$(subp pax)]
::
::  watch board dir for changes
++  watch-dir
  |=  a/path
  ~&  [%watch-dir a]
  ^-  (list move)
  =/  soc/sock
    [our.hid our.hid]
  =/  rav/rave
    [%next %z da+now.hid a]
  =/  rif/riff
    [%home [~ rav]]
  =/  car/card
    :^
      %warp
      a
      soc
      rif
  [[ost.hid car] ~]
::
::
:: accepts incoming writ
++  writ                                         
  |=  {way/wire rot/riot}
  ~&  [%rot rot]
  ::  will update subscribers that node changed
  ::  once that works reasonably
  ::=/  car/card
  ::  :+
  ::    %diff
  ::    %json
  ::    %+
  ::      joba
  ::      'updated'
  ::      (jape "true")
  :::-
  ::  %+  welp
  ::    %+  turn  (prey subp hid)
  ::      |=  {o/bone *}
  ::      [o car]
  [(watch-dir way) +>.$]
--
