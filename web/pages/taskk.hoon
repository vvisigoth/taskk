/?    310
!:
;html
  ;head
    ;script(type "text/javascript", src "/~~/~/at/lib/jquery.min.js"); 
    ;script(type "text/javascript", src "/~~/~/at/lib/js/urb.js");
    ;link/"/pages/taskk.css"(rel "stylesheet");
    ;link/"/lib/css/fonts.css"(rel "stylesheet");
    ;title: TASKK
  ==
  ;body
    ;div#cont
      ;div#col0(class "column todo")
        ;div(class "headlet")
          ;div(class "headlet-container"):"TODO"
          ;div(class "add-button"):"+"
        ==
        ;div(class "col-container");
      ==
      ;div#col1(class "column doin")
        ;div(class "headlet")
          ;div(class "headlet-container"):"DOIN"
          ;div(class "add-button"):"+"
        ==
        ;div(class "col-container");
      ==
      ;div#col2(class "column show")
        ;div(class "headlet")
          ;div(class "headlet-container"):"SHOW"
          ;div(class "add-button"):"+"
        ==
        ;div(class "col-container");
      ==
      ;div#col3(class "column done")
        ;div(class "headlet")
          ;div(class "headlet-container"):"DONE"
          ;div(class "add-button"):"+"
        ==
        ;div(class "col-container");
      ==
      ;div#empty-message;    
    ==
    ;script(type "text/javascript", src "/pages/taskk.js");
  ==
==
