# frozen_string_literal: true

describe DoCommand do
  class PositionGatewayFake
    attr_accessor :position

    def retrieve
      @position.dup
    end

    def save(position)
      @position = position
    end
  end

  let(:position_gateway_fake) { PositionGatewayFake.new }
  let(:command_gateways) do
    {
      position_gateway: position_gateway_fake,
      motor_gateway: nil,
      sensor_gateway: nil
    }
  end

  it 'can move the rover forward one when given the forward command' do
    position_gateway_fake.position = {
      position_x: 0,
      position_y: 0,
      direction: :north
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      commands: [:f]
    )

    expect(position_gateway_fake.position).to eq(
      position_x: 0,
      position_y: 1,
      direction: :north
    )
  end

  it 'can move the rover forward two units when given two forward commands' do
    position_gateway_fake.position = {
      position_x: 0,
      position_y: 0,
      direction: :north
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      commands: %i[f f]
    )

    expect(position_gateway_fake.position).to eq(
      position_x: 0,
      position_y: 2,
      direction: :north
    )
  end

  it 'can move the rover forward three units when given three forward commands' do
    position_gateway_fake.position = {
      position_x: 0,
      position_y: 0,
      direction: :north
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      commands: %i[f f f]
    )

    expect(position_gateway_fake.position).to eq(
      position_x: 0,
      position_y: 3,
      direction: :north
    )
  end

  it 'can move the rover forward from a different starting position' do
    position_gateway_fake.position = {
      position_x: 0,
      position_y: 1,
      direction: :north
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      commands: [:f]
    )

    expect(position_gateway_fake.position).to eq(
      position_x: 0,
      position_y: 2,
      direction: :north
    )
  end

  it 'can move the rover forward towards west' do
    position_gateway_fake.position = {
      position_x: 0,
      position_y: 0,
      direction: :west
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      commands: [:f]
    )

    expect(position_gateway_fake.position).to eq(
      position_x: -1,
      position_y: 0,
      direction: :west
    )
  end

  it 'can move the rover forward three units towards west' do
    position_gateway_fake.position = {
      position_x: 0,
      position_y: 0,
      direction: :west
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      commands: %i[f f f]
    )

    expect(position_gateway_fake.position).to eq(
      position_x: -3,
      position_y: 0,
      direction: :west
    )
  end

  it 'can move the rover forward three units towards east' do
    position_gateway_fake.position = {
      position_x: 0,
      position_y: 0,
      direction: :east
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      commands: %i[f f f]
    )

    expect(position_gateway_fake.position).to eq(
      position_x: 3,
      position_y: 0,
      direction: :east
    )
  end

  it 'can move the rover forward three units towards south' do
    position_gateway_fake.position = {
      position_x: 0,
      position_y: 0,
      direction: :south
    }

    do_command = DoCommand.new(command_gateways)
    do_command.execute(
      commands: %i[f f f]
    )

    expect(position_gateway_fake.position).to eq(
      position_x: 0,
      position_y: -3,
      direction: :south
    )
  end

  context 'when given the backward command' do
    it 'can move one unit towards south' do
      position_gateway_fake.position = {
        position_x: 0,
        position_y: 0,
        direction: :north
      }

      do_command = DoCommand.new(command_gateways)
      do_command.execute(
        commands: %i[b]
      )

      expect(position_gateway_fake.position).to eq(
        position_x: 0,
        position_y: -1,
        direction: :north
      )
    end

    it 'can move one unit towards west' do
      position_gateway_fake.position = {
        position_x: 0,
        position_y: 0,
        direction: :east
      }

      do_command = DoCommand.new(command_gateways)
      do_command.execute(
        commands: %i[b]
      )

      expect(position_gateway_fake.position).to eq(
        position_x: -1,
        position_y: 0,
        direction: :east
      )
    end
  end
end
