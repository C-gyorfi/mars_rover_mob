# frozen_string_literal: true

class DoCommand
  def initialize(gateways)
    @position_gateway = gateways[:position_gateway]
  end

  def execute(commands:)
    position = @position_gateway.retrieve

    position[:position_y] += commands.length

    @position_gateway.save(position)
  end
end
