class PositionGatewayStub
  attr_writer :position

  def retrieve
    @position.dup
  end
end

class MotorGateway
end