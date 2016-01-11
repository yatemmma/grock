class Band < Model
  def link(name)
    return nil if @hash[name.to_s].empty?
    @hash[name.to_s]
  end
end
