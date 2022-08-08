class Didcomm::Jwm

  attr_reader :id, :type, :body

  def initialize(attributes)
    @id = attributes[:id]
    @type = 'https://www.w3.org/ns/activitystreams'
    @body = attributes[:body]
  end

  def to_hash
    {
      id: id,
      type: type,
      body: body
    }
  end

end
