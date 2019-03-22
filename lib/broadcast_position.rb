# frozen_string_literal: true

class BroadcastPosition
  def initialize(position_gateway:)
    @position_gateway = position_gateway
  end

  def execute(*)
    @position_gateway.retrieve
  end
end
