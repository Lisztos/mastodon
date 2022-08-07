class Mediators::ResolveAccountMediator 

  def self.mediate_account_resolving(query)
    if query.include?(Did::DID_PREFIX)
      Did::ResolveAccountService.new.call(query)
    else
      ResolveAccountService.new.call(query)
    end
  end
end