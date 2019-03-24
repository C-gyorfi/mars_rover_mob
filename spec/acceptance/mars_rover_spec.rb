describe 'Mars Rover' do
  class InMemoryPositionGateway
    attr_accessor :position

    def retrieve
      @position.dup
    end

    def save(position)
      @position = position
    end
  end

  class MotorGateway
  end

  let(:position_gateway) { InMemoryPositionGateway.new }
  let(:motor_gateway) { MotorGateway.new }

  before(:example) do
    position_gateway.position = {
      position_x: 0,
      position_y: 0,
      direction: :north
    }
  end

  it 'can move forward 1 unit' do
    command_gateways = {
      position_gateway: position_gateway,
      motor_gateway: motor_gateway,
      sensor_gateway: nil
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      {
        commands: [:f]
      }
    )

    broadcast_position = BroadcastPosition.new(position_gateway: position_gateway)

    expect(broadcast_position.execute({})).to eq(
      {
        position_x: 0,
        position_y: 1,
        direction: :north
      }
    )
  end

  it 'can follow an array of commands' do
    command_gateways = {
      position_gateway: position_gateway,
      motor_gateway: motor_gateway,
      sensor_gateway: nil
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      commands: %i[f l f l]
    )

    broadcast_position = BroadcastPosition.new(position_gateway: position_gateway)

    expect(broadcast_position.execute({})).to eq(
      {
        position_x: -1,
        position_y: 1,
        direction: :south
      }
    )
  end
end
