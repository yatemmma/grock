module MemberHelper
  def guests?
    (guests || []).map do |guest|
      [Metadata.member[guest["code"]], guest]
    end
  end
end
