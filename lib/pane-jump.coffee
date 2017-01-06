module.exports =
  activate: (state) ->
    for i in [1..9]
      do (i) => atom.commands.add 'atom-workspace',
        "pane-jump:go-to-pane-#{i}", => @goToPane(i)

  goToPane: (paneId) ->
    pane = @getPane(paneId-1)
    if pane
      pane.focus()

  getPane: (paneIndex) ->

    panes = atom.workspace.getPanes()
    rects = @getRects panes
    @sortRects rects
    if paneIndex >= rects.length
      return undefined
    return rects[paneIndex].pane

  getRects: (panes) ->
    rects = []
    for p in panes
      e = atom.views.getView(p)
      rect =
        bounding:
          e.getBoundingClientRect()
        pane:
          p
      rects.push(rect)
    return rects

  sortRects: (rects) ->
    rects.sort (a, b) ->
      tdiff = a.bounding.top - b.bounding.top
      if tdiff == 0
        return a.bounding.left - b.bounding.left
      return tdiff
