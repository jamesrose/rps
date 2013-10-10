require 'eventmachine'

module NewPlayerNotification
  def self.notify(game, person)
    client = Faye::Client.new('http://localhost:9292/faye')  
    client.publish("/games/#{game.id}", { type: :player_connected, name: person.name })
  end
end
