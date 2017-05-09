$(function() {
  window.urb.appl = "taskk"
  window.urb.bind('/sub-path',
    function(err,dat) {
      console.log(dat);
    }
  )
})
