###
  @module document
  @description Mock the window.document
###
module.exports  = if window? then window.document else {createElement: ()->}
