require 'eventmachine'

module NewPlayerNotification
  def self.notify(game, person)
    client = Faye::Client.new(FAYE_URL)
    client.publish("/games/#{game.id}", { type: :player_connected, name: person.name })
  end
end
