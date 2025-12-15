# Creating a Level

This document explains how to create levels for the game.

Levels are collections of scenes called rooms. We create levels by stringing rooms together.

For this example, we will create a level for the **vertical slice**

## 1. Copying the base scene

First, we create a duplicate of the [base scene](./base_scene.tscn) file, by right clicking and selecting "duplicate". 

Rooms use the following name convention:
```
lvl_[the level]_room_[number]
```

![](img/2025-12-15-12-16-09.png)

Dont forget to move the level to its corresponding folder (in this case, "vertical_slice")

> Note: vs stands for "vertical slice"

## 2. Room structure

Opening the scene will reveal a series of nodes:

### ScreenSizeReference 

Size of the screen when the game is running. Anything outside that rectangle wont be shown to the player.

### TileMapLayer

A tilemap with a tileset setup. It uses a special material that replaces the colors with a custom palette.

### LevelInfo

LevelInfo: this node contains important information about the room:

1. Level name: The name/id of the level. Will be used to transition between rooms. Its setup automatically by [REFERENCE0]
2. Area Type: indicates the color palette this room will use.