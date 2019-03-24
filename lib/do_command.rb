# frozen_string_literal: true

class DoCommand
  def initialize(gateways)
    @position_gateway = gateways[:position_gateway]
  end

  def execute(commands:)
    position = @position_gateway.retrieve

    if commands.first == :b
      if position[:direction] == :north
        position[:position_y] -= commands.length
      elsif position[:direction] == :east
        position[:position_x] -= commands.length
      end
    elsif position[:direction] == :west
      position[:position_x] -= commands.length
    elsif position[:direction] == :east
      position[:position_x] += commands.length
    elsif position[:direction] == :south
      position[:position_y] -= commands.length
    else
      position[:position_y] += commands.length
    end
    @position_gateway.save(position)
  end
end
