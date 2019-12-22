return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 16,
  tilewidth = 8,
  tileheight = 8,
  nextlayerid = 2,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "TileSet",
      firstgid = 1,
      filename = "../../../../TileSet.tsx",
      tilewidth = 8,
      tileheight = 8,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "../../../../revolution_tiles.png",
      imagewidth = 64,
      imageheight = 48,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 8,
        height = 8
      },
      properties = {},
      terrains = {},
      tilecount = 48,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 1,
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        1, 1, 1, 1, 1, 1, 1, 1, 3, 4, 6, 12, 39, 37, 37, 37,
        1, 1, 1, 1, 10, 1, 1, 1, 11, 1, 1, 12, 39, 39, 37, 37,
        1, 1, 3, 4, 5, 4, 5, 5, 1, 1, 1, 1, 12, 39, 39, 39,
        1, 1, 11, 1, 13, 1, 1, 1, 13, 1, 33, 34, 1, 1, 1, 39,
        1, 1, 11, 13, 1, 1, 1, 1, 1, 1, 41, 42, 1, 1, 1, 1,
        1, 1, 11, 1, 1, 13, 1, 35, 36, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 19, 20, 21, 22, 23, 43, 44, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 3, 5, 6, 13, 1, 1, 5, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 11, 7, 12, 12, 1, 1, 5, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 19, 20, 21, 22, 1, 1, 5, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    }
  }
}
