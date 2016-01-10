class Post
  def self.cols
    %w(id title date bands type body)
  end
  
  def self.all
    items = DB[:posts]
    items.all
  end
  
  def self.add(params)
    items = DB[:posts]
    items.insert({
      :id => params[:id],
      :title => params[:title],
      :date => params[:date],
      :bands => params[:bands],
      :type => params[:type],
      :body => params[:body]
    })
  end
  
  def self.get(id)
    Label.new(id).first
  end
  
  def initialize(id)
    items = DB[:posts]
    @item = items.where(:id => id)
  end
  
  def update(params)
    @item.update({
      :title => params[:title],
      :date => params[:date],
      :bands => params[:bands],
      :type => params[:type],
      :body => params[:body]
    })
  end
  
  def delete
    @item.delete
  end
end
