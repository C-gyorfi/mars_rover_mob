# frozen_string_literal: true

describe BroadcastPosition do
  let(:position_gateway) { PositionGatewayStub.new }

  it 'sends the position of the rover' do
    position_gateway.position = {
      position_x: 0,
      position_y: 0,
      direction: :north
    }

    broadcast_position = BroadcastPosition.new(position_gateway: position_gateway)
    expect(broadcast_position.execute).to eq(
      position_gateway.position = {
        position_x: 0,
        position_y: 0,
        direction: :north
      }
    )
  end

  it 'sends a different position of the rover' do
    position_gateway.position = {
      position_x: -21,
      position_y: 21,
      direction: :east
    }

    broadcast_position = BroadcastPosition.new(position_gateway: position_gateway)
    expect(broadcast_position.execute).to eq(
      position_gateway.position = {
        position_x: -21,
        position_y: 21,
        direction: :east
      }
    )
  end

  it 'sends the position of the rover after updated' do
    position_gateway.position = {
      position_x: 1,
      position_y: 1,
      direction: :west
    }

    broadcast_position = BroadcastPosition.new(position_gateway: position_gateway)
    expect(broadcast_position.execute).to eq(
      position_gateway.position = {
        position_x: 1,
        position_y: 1,
        direction: :west
      }
    )

    position_gateway.position = {
      position_x: -2,
      position_y: 1,
      direction: :north
    }

    broadcast_position = BroadcastPosition.new(position_gateway: position_gateway)
    expect(broadcast_position.execute).to eq(
      position_gateway.position = {
        position_x: -2,
        position_y: 1,
        direction: :north
      }
    )
  end
end
