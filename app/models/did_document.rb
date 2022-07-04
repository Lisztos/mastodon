class DidDocument

  attr_reader :id,
              :publicKey,
              :authentication,
              :assertionMethod,
              :capabilityDelegation,
              :capabilityInvocation,
              :keyAgreement,
              :service

  def initialize(attributes)
    @id = attributes['id']
    @publicKey = attributes['publicKey']
    @authentication = attributes['authentication']
    @assertionMethod = attributes['assertionMethod']
    @capabilityDelegation = attributes['capabilityDelegation']
    @capabilityInvocation = attributes['capabilityInvocation']
    @keyAgreement = attributes['keyAgreement']
    @service = attributes['service']
  end

end