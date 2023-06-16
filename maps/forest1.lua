return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 20,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 4,
  nextobjectid = 8,
  properties = {},
  tilesets = {
    {
      name = "Overworld",
      firstgid = 1,
      class = "",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 40,
      image = "../images/gfx/Overworld.png",
      imagewidth = 640,
      imageheight = 576,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 1440,
      tiles = {}
    },
    {
      name = "tree",
      firstgid = 1441,
      class = "",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "../images/tree.png",
      imagewidth = 66,
      imageheight = 152,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 36,
      tiles = {}
    },
    {
      name = "treeSmall",
      firstgid = 1477,
      class = "",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "../images/tree.png",
      imagewidth = 66,
      imageheight = 152,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 36,
      tiles = {}
    },
    {
      name = "tree",
      firstgid = 1513,
      class = "",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 4,
      image = "../images/tree.png",
      imagewidth = 66,
      imageheight = 152,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 36,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      id = 1,
      name = "Ground",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      id = 2,
      name = "Objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        1441, 1442, 1443, 1444, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1445, 1446, 1447, 1448, 1441, 1442, 1443, 1444, 0, 0, 0, 0, 1441, 1442, 1443, 1444, 0, 0, 0, 0,
        1449, 1450, 1451, 1452, 1445, 1446, 1447, 1448, 0, 0, 0, 0, 1445, 1446, 1447, 1448, 0, 0, 0, 0,
        1453, 1454, 1455, 1456, 1449, 1450, 1451, 1452, 0, 0, 0, 0, 1449, 1450, 1451, 1452, 0, 0, 0, 0,
        1457, 1458, 1459, 1460, 1453, 1454, 1455, 1456, 0, 0, 0, 0, 1453, 1454, 1455, 1456, 0, 0, 0, 0,
        1461, 1462, 1463, 1464, 1457, 1458, 1459, 1460, 0, 0, 0, 0, 1457, 1458, 1459, 1460, 0, 0, 0, 0,
        1465, 1466, 1467, 1468, 1461, 1462, 1463, 1464, 0, 0, 0, 0, 1461, 1462, 1463, 1464, 0, 0, 0, 0,
        1469, 1470, 1471, 1472, 1465, 1466, 1467, 1468, 1441, 1442, 1443, 1444, 1465, 1466, 1467, 1468, 0, 0, 0, 0,
        1473, 1474, 1475, 1476, 1469, 1470, 1471, 1472, 1445, 1446, 1447, 1448, 1469, 1470, 1471, 1472, 0, 0, 0, 0,
        0, 1441, 1442, 1443, 1444, 1474, 1475, 1476, 1449, 1450, 1451, 1452, 1473, 1474, 1475, 1476, 0, 0, 0, 0,
        0, 1445, 1446, 1447, 1448, 0, 0, 0, 1453, 1454, 1455, 1456, 0, 0, 0, 0, 1441, 1442, 1443, 1444,
        0, 1449, 1450, 1451, 1452, 0, 0, 0, 1457, 1458, 1459, 1460, 1441, 1442, 1443, 1444, 1445, 1446, 1447, 1448,
        0, 1453, 1454, 1455, 1456, 0, 0, 0, 1461, 1462, 1463, 1464, 1445, 1446, 1447, 1448, 1449, 1450, 1451, 1452,
        0, 1457, 1458, 1459, 1460, 0, 0, 0, 1465, 1466, 1467, 1468, 1449, 1450, 1451, 1452, 1453, 1454, 1455, 1456,
        0, 1461, 1462, 1463, 1464, 0, 0, 0, 1469, 1470, 1471, 1472, 1453, 1454, 1455, 1456, 1457, 1458, 1459, 1460,
        0, 1465, 1466, 1467, 1468, 0, 0, 0, 1473, 1474, 1475, 1476, 1457, 1458, 1459, 1460, 1461, 1462, 1463, 1464,
        0, 1469, 1470, 1471, 1472, 0, 0, 0, 0, 0, 0, 0, 1461, 1462, 1463, 1464, 1465, 1466, 1467, 1468,
        0, 1473, 1474, 1475, 1476, 0, 0, 0, 0, 0, 0, 0, 1465, 1466, 1467, 1468, 1469, 1470, 1471, 1472,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1469, 1470, 1471, 1472, 1473, 1474, 1475, 1476,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1473, 1474, 1475, 1476, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "Walls",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 16,
          y = 128,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 144,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 144,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 144,
          y = 240,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 32,
          y = 272,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 304,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 288,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
