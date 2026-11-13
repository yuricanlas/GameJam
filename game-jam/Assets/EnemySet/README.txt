Sci-Fi Space Station Tileset (Free Demo)
========================================

A free demo of the Sci-Fi Space Station Tileset: a few floors and walls, the
steel wall-top and floor-on-space autotiles, the floor markings, a starter
set of station furniture and machines, eight animated objects and four
characters (two crew, one alien, one robot) with all their animations, on a
16 x 16 grid in x1, x2 and x4.

WHAT'S INSIDE
  372 unique tiles, objects, animations and character strips (every image
  counted once, duplicates removed)
  179 tiles: 4 floors x 4 variants, 3 wall faces x 4 pieces, the steel wall-
  top autotile, the floor-on-space autotile (47-tile blob) and 49 floor
  markings
  89 objects:
    Command bridge: 11
    Laboratory: 8
    Medbay: 2
    Hangar: 5
    Reactor: 5
    Mess hall: 11
    Crew quarters: 5
    Cryo bay: 1
    Armory: 6
    Greenhouse: 2
    Cargo bay: 7
    Server & comms room: 1
    Observation lounge: 12
    Shared station decor (doors, signs, windows, lights, crates): 13
  8 animated objects (34 frames)
  2 crew members and 2 aliens and robots x 4 directions x 6 animations
  (idle, walk, interact, shoot, hurt, death): 96 strips, 432 frames:
  captain, engineer, grey alien, security robot

FOLDERS
  willosuna_station/x1/tiles/            floors, walls, autotiles, markings
  willosuna_station/x1/objects/<theme>/  furniture and machines
  willosuna_station/x1/animations/       strips and single frames
  willosuna_station/x1/characters/       four characters, strips + sheet
  willosuna_station/x2/ and x4/          the same files at 2x and 4x
  willosuna_station/godot/ and tiled/    TileSets, SpriteFrames, tsx
  willosuna_station/manifest.json        every file, size and fps

GRID AND PIVOT
  Everything sits on a 16 x 16 grid and comes in x1, x2 and x4 (scale only
  by whole numbers, nearest-neighbour). Objects and characters stand on the
  bottom centre of their canvas; canvases are multiples of 16, so snapping
  the bottom edge to the grid lines them up with the tiles. manifest.json
  lists every file with its size, theme, layer, frames and fps.

BUILDING A ROOM
  1. Floor: tiles/floors.png, one floor per row, 4 variants per row (mix
     them at random so large floors do not repeat).
  2. Wall face: tiles/walls.png, one wall per row. Put an "upper" tile on
     top of a "lower" tile: a wall face is two tiles high. Use "upper with
     shadow" next to corners and "lower with vent" for detail.
  3. Wall tops: tiles/wall_tops_<colour>.png is a 47-tile blob autotile
     (the glass one makes window walls). Paint the thick top edge of every
     wall and pick the tile by its 8-neighbour mask (manifest.json).
  4. Objects: rugs first, then furniture sorted by their bottom edge, wall
     objects (windows, screens, signs, doors) on the wall face.

CHARACTERS
  characters/crew/<name>/ and characters/aliens_robots/<name>/ hold one
  strip per animation and direction (<name>_<anim>_<direction>.png) and a
  full <name>_sheet.png (rows: down, left, right, up x idle 4, walk 6,
  interact 4, shoot 4, hurt 3, death 6; 6 columns). Crew frames are
  16 x 32, the big aliens and robots 32 x 32 (see manifest.json).
  Suggested fps: idle 4, walk 10, interact 6, shoot 10, hurt 8, death 8
  (play death once). Hurt frame 0 is a white hit flash.

ANIMATED OBJECTS
  animations/<theme>/<name>_strip.png plus one PNG per frame in
  animations/<theme>/<name>/. Frames, fps and size are in manifest.json.

ENGINES
  Godot 4: godot/floor_on_space.tres and wall_tops_steel.tres are ready
  terrain TileSets and godot/spriteframes/ has the four characters. Tiled:
  tiled/ has the tilesets with their Wang sets. Unity, GameMaker and
  others: import the PNGs with nearest-neighbour (Filter Point), 16 pixels
  per unit, pivot bottom.

WANT THE FULL PACK?
  Sci-Fi Space Station Tileset: 3683 unique sprites. 15 room themes with
  1224 objects, 217 animated objects, 24 crew members and 13 aliens and
  robots with 6 animations in 4 directions, a crew generator, a Godot 4 demo
  station and an RPG Maker MZ/MV version. Name your own price from $1.99.
  https://willosuna.itch.io/scifi-space-station-tileset

LICENSE
  Free for commercial use, royalty free, no attribution required.
  Reselling or redistributing the image files as an asset pack is not
  permitted. Full terms in LICENSE.txt
