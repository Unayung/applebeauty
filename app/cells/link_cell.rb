class LinkCell < Cell::Rails

  cache :item, :expires_in => 6.hours do |cell, item|
    "#{item[:link].id}-#{item[:link].updated_at}-xx"
  end

  def item(args)
    @link = args[:link]
    render
  end

end
