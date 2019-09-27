module ChunksHelper
  def tile_classes(tile_type, x, y, impassable)
    [
      "tile",
      "tile-#{tile_type}",
      impassable ? "impassable" : nil,
    ].compact.join(" ")
  end

  def entity_classes(entity)
    [
      "entity",
      "entity-#{entity.entity_type}",
    ].compact.join(" ")
  end

  def player_classes(player)
    [
      "player",
      "player-level#{player.level}",
      "player-gender-#{player.gender}",
      "running",
    ].compact.join(" ")
  end

  def display_width
    32
  end

  def display_height
    32
  end
end
