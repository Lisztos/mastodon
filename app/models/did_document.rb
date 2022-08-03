class DidDocument

  DIDCOMM_KEY_SELECTOR = "#delegate-1".freeze

  attr_reader :id,
              :publicKey,
              :authentication,
              :assertionMethod,
              :capabilityDelegation,
              :capabilityInvocation,
              :verificationMethod,
              :service

  def initialize(attributes)
    @id = attributes['id']
    @publicKey = attributes['publicKey']
    @authentication = attributes['authentication']
    @assertionMethod = attributes['assertionMethod']
    @verificationMethod = attributes['verificationMethod']
    @service = attributes['service']
  end

  def rsa_didcomm_key
    pem = dig_didcomm_key['publicKeyPem']
    key = clean_pem(pem)
    return OpenSSL::PKey::RSA.new(key) 
  end

  def activitypub_enpoint
    service[0]['serviceEndpoint']
  end

  private

  def dig_didcomm_key
    key = nil
    verificationMethod.each do |k|
      if k['id'].include?(DIDCOMM_KEY_SELECTOR)
        key = k
      end
    end
    key
  end

  def clean_pem(pem)
    p = pem.gsub(' ', '')
    p = p.gsub('ENDPUBLICKEY', 'END PUBLIC KEY')
    p = p.gsub('BEGINPUBLICKEY', 'BEGIN PUBLIC KEY')
    p = p.gsub('ENDPRIVATEKEY', 'END PRIVATE KEY')
    p = p.gsub('BEGINPRIVATEKEY', 'BEGIN PRIVATE KEY')
  end

end