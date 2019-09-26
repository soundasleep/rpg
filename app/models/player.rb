class Player < ApplicationRecord
  belongs_to :chunk

  validates :title, :level, :health, :mana, presence: true

  def respawn_in_world(world)
    x, y = world.spawn_x, world.spawn_y

    player_spawn = world.find_chunk(x, y)

    assign_attributes(
      chunk: player_spawn[:chunk],
      chunk_x: player_spawn[:chunk_x],
      chunk_y: player_spawn[:chunk_y],
    )
  end

  def world_x
    (chunk.world_x * chunk.chunk_width) + chunk_x
  end

  def world_y
    (chunk.world_y * chunk.chunk_height) + chunk_y
  end

  def describe
    "\"#{title}\" (level #{level})"
  end
end
